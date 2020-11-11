require "bigdecimal"

require "prices"

class Checkout
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @cart = []
  end

  def scan(item_code)
    # XXX maybe move this to private method
    selected_item = Prices.list.select { |item| item[:code] == item_code }.first

    if selected_item
      # not sure about ruby referencing object
      item = selected_item.dup
      # copy original price to be changed by promotions
      item[:cart_price] = item[:price]
      @cart << item
    end
  end

  def total
    updte_product_price_for_quantity

    price = cart_total_price

    total_promotion = total_promotion_for_price(price)
    if total_promotion
      price -= (price * 0.01 * total_promotion[:reduction_percent]).round(2, :down)
    end

    # https://ruby-doc.org/stdlib-2.7.1/libdoc/bigdecimal/rdoc/BigDecimal.html
    return convert_currency(price)
  end

  private

  def cart_total_price
    @cart.map { |item| BigDecimal(item[:cart_price]) }.sum
  end

  def total_promotion_for_price(price)
    selected_promotions = @promotional_rules.select {|rule| rule[:spend_over] && (rule[:spend_over] <= price)}
    # highest price reduction
    best_promotion = selected_promotions.sort {|a,b| a[:reduction_percent] <=> b[:reduction_percent] }.last
    return best_promotion
  end

  def updte_product_price_for_quantity
    product_names_in_cart = @cart.map{|item| item[:name]}.uniq

    # this hash is not used but I feel this could be used soon
    product_quantities = {}
    product_names_in_cart.each do |name|
      product_quantities[name] = @cart.select{|item| item[:name] == name}.size

      selected_promotions = @promotional_rules.select { |rule|
        rule[:quantity_equal_or_over] &&
        rule[:new_price] &&
        rule[:quantity_equal_or_over] <= product_quantities[name] &&
        rule[:product_name] == name
      }
      # lowest price
      best_promotion = selected_promotions.sort {|a,b| a[:new_price] <=> b[:new_price] }.first

      if best_promotion
        # update cart_price
        @cart.select do |item|
          # XXX it would be better to convert to Struct/Class
          # if will secure wrong Hash key error
          item[:name] == name
        end.each do |item|
          item[:cart_price] = best_promotion[:new_price]
        end
      end
    end
  end

  def convert_currency(price)
    sprintf("£%.2f", price.truncate(2))
  end
end
