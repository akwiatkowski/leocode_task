RSpec.describe Checkout do
  # TODO better structurize tests
  it "calculates total price - 1 product" do
    co = Checkout.new(promotional_rules)
    co.scan("001")
    price = co.total

    expect(price).to eq("9.25")
  end

  # it "calculates total price - sample 1" do
  #   co = Checkout.new(promotional_rules)
  #   co.scan("001")
  #   co.scan("002")
  #   co.scan("003")
  #   price = co.total
  #
  #   expect(price).to eq(66.78)
  # end
end
