class Prices
  def self.list

    return [
      {
        code: "001",
        name: "Red Scarf",
        price: BigDecimal("9.25")
      },
      {
        code: "002",
        name: "Silver cufflinks",
        price: BigDecimal("45.00")
      },
      {
        code: "003",
        name: "Silk Dress",
        price: BigDecimal("19.95")
      }
    ]

  end
end
