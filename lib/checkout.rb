# frozen_string_literal: true

require "bigdecimal"

require "models/cart_element"
require "models/product"
require "models/promotion_total"
require "models/promotion_quantity"

require "prices"


class Checkout
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @cart = []
  end

  def scan(item_code)
    # XXX maybe move this to private method
    selected_item = Prices.list.select { |item| item.code == item_code }.first

    if selected_item
      item = CartElement.new(selected_item)
      @cart << item
    end
  end

  def total
    updte_product_price_for_quantity

    price = cart_total_price

    total_promotion = total_promotion_for_price(price)
    price -= (price * 0.01 * total_promotion.reduction_percent).round(2, :down) if total_promotion

    # https://ruby-doc.org/stdlib-2.7.1/libdoc/bigdecimal/rdoc/BigDecimal.html
    convert_currency(price)
  end

  private

  def cart_total_price
    @cart.map { |item| BigDecimal(item.cart_price) }.sum
  end

  def total_promotion_for_price(price)
    selected_promotions = @promotional_rules.select { |rule| rule.is_a?(PromotionTotal) && (rule.spend_over <= price) }
    # highest price reduction
    selected_promotions.max { |a, b| a.reduction_percent <=> b.reduction_percent }
  end

  def updte_product_price_for_quantity
    product_names_in_cart = @cart.map(&:name).uniq

    # this hash is not used but I feel this could be used soon
    product_quantities = {}
    product_names_in_cart.each do |name|
      product_quantities[name] = @cart.select { |item| item.name == name }.size

      selected_promotions = @promotional_rules.select do |rule|
        rule.is_a?(PromotionQuantity) &&
          rule.quantity_equal_or_over <= product_quantities[name] &&
          rule.product_name == name
      end
      # lowest price
      best_promotion = selected_promotions.min { |a, b| a.new_price <=> b.new_price }

      next unless best_promotion

      # update cart_price
      @cart.select do |item|
        # XXX it would be better to convert to Struct/Class
        # if will secure wrong Hash key error
        item.name == name
      end.each do |item|
        item.update_cart_price(best_promotion.new_price)
      end
    end
  end

  def convert_currency(price)
    format("£%.2f", price.truncate(2))
  end
end
