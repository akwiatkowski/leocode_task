# frozen_string_literal: true

def promotional_rules
  [
    PromotionTotal.new(BigDecimal("60.0"), 10),
    PromotionQuantity.new("Red Scarf", 2, BigDecimal("8.5"))
  ]
end
