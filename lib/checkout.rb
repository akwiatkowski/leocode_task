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
    # https://ruby-doc.org/stdlib-2.7.1/libdoc/bigdecimal/rdoc/BigDecimal.html
    @cart.map { |item| BigDecimal(item[:price]) }.sum.to_s("2F")
  end
end
