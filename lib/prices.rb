class Prices
  def self.list

    return [
      {
        code: "001",
        name: "Red Scarf",
        price: "9.25" # will be converted to BigDecimal
      },
      {
        code: "002",
        name: "Silver cufflinks",
        price: "45.00" # will be converted to BigDecimal
      },
      {
        code: "003",
        name: "Silk Dress",
        price: "19.95" # will be converted to BigDecimal
      }
    ]

  end
end
