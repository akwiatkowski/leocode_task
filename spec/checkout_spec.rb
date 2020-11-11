RSpec.describe Checkout do
  # TODO better structurize tests
  it "calculates total price - 1 product" do
    co = Checkout.new(promotional_rules)
    co.scan("001")
    price = co.total

    expect(price).to eq("£9.25")
  end

  it "calculates total price - over £60" do
    co = Checkout.new(promotional_rules)
    # 2 times "002" is 2x45, it's over £60
    co.scan("002")
    co.scan("002")
    price = co.total

    # £90.00 minus 10% => £81
    expect(price).to eq("£81.00")
  end

  # it "calculates total price - sample 1" do
  #   co = Checkout.new(promotional_rules)
  #   co.scan("001")
  #   co.scan("002")
  #   co.scan("003")
  #   price = co.total
  #
  #   expect(price).to eq("£66.78")
  # end
end
