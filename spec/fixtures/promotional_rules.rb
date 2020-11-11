def promotional_rules
  # I could have created Class or Struct and check later because normally
  # that kind of data would be fetched from DB but in case
  # you would like to load from JSON/YAML I use Hash/Array here
  [
    {
      spend_over: BigDecimal("60.0"),
      reduction_percent: 10,
    },
    {
      quantity_equal_or_over: 2,
      product_name: "Red Scarf", # could use product code instead
      new_price: BigDecimal("8.5"),
    }
  ]
end
