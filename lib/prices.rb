# XXX struct works better in Crystal
Product = Struct.new(:code, :name, :price)

class Prices
  def self.list

    return [
      Product.new(
        "001",
        "Red Scarf",
        BigDecimal("9.25")
      ),
      Product.new(
        "002",
        "Silver cufflinks",
        BigDecimal("45.00")
      ),
      Product.new(
        "003",
        "Silk Dress",
        BigDecimal("19.95")
      ),
    ]

  end
end
