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
    @cart << selected_item if selected_item
  end

  def total
    price = cart_total_price

    total_promotion = total_promotion_for_price(price)
    if total_promotion
      price -= price * 0.01 * total_promotion[:reduction_percent]
    end

    # https://ruby-doc.org/stdlib-2.7.1/libdoc/bigdecimal/rdoc/BigDecimal.html
    return convert_currency(price)
  end

  private

  def cart_total_price
    @cart.map { |item| BigDecimal(item[:price]) }.sum
  end

  def total_promotion_for_price(price)
    selected_promotions = @promotional_rules.select {|rule| rule[:spend_over] && (rule[:spend_over] <= price)}
    best_promotion = selected_promotions.sort {|a,b| a[:reduction_percent] <=> b[:reduction_percent] }.last
    return best_promotion
  end

  def convert_currency(price)
    sprintf("£%.2f", price.truncate(2))
  end
end
