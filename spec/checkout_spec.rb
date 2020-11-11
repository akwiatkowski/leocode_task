# frozen_string_literal: true

RSpec.describe Checkout do
  # TODO: better structurize tests
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

  it "calculates total price - 2 Red Scarf" do
    co = Checkout.new(promotional_rules)
    # 2 times "001" changes price from 9.25 to 8.50
    co.scan("001")
    co.scan("001")
    price = co.total

    expect(price).to eq("£17.00")
  end

  it "calculates total price - sample 1" do
    co = Checkout.new(promotional_rules)
    co.scan("001")
    co.scan("002")
    co.scan("003")
    price = co.total

    expect(price).to eq("£66.78")
  end

  it "calculates total price - sample 2" do
    co = Checkout.new(promotional_rules)
    co.scan("001")
    co.scan("003")
    co.scan("001")
    price = co.total

    expect(price).to eq("£36.95")
  end

  it "calculates total price - sample 3" do
    co = Checkout.new(promotional_rules)
    co.scan("001")
    co.scan("002")
    co.scan("001")
    co.scan("003")
    price = co.total

    expect(price).to eq("£73.76")
  end
end
