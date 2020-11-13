# frozen_string_literal: true

RSpec.describe Checkout do
  context "when only product 001 is scanned" do
    it "calculates simple total price" do
      co = Checkout.new(promotional_rules)
      co.scan("001")
      price = co.total

      expect(price).to eq("£9.25")
    end
  end

  context "when 2 * 002 products are scanned" do
    it "calculates proper total price using total promotion" do
      co = Checkout.new(promotional_rules)
      # 2 times "002" is 2x45, it's over £60
      co.scan("002")
      co.scan("002")
      price = co.total

      # £90.00 minus 10% => £81
      expect(price).to eq("£81.00")
    end
  end

  context "when 2 * 001 products are scanned" do
    it "calculates proper total price using quantity promotion" do
      co = Checkout.new(promotional_rules)
      # 2 times "001" changes price from 9.25 to 8.50
      co.scan("001")
      co.scan("001")
      price = co.total

      expect(price).to eq("£17.00")
    end
  end

  context "when 001, 002, 003 are scanned" do
    it "calculates proper total price" do
      co = Checkout.new(promotional_rules)
      co.scan("001")
      co.scan("002")
      co.scan("003")
      price = co.total

      expect(price).to eq("£66.78")
    end
  end

  context "when 001, 003, 001 are scanned" do
    it "calculates proper total price" do
      co = Checkout.new(promotional_rules)
      co.scan("001")
      co.scan("003")
      co.scan("001")
      price = co.total

      expect(price).to eq("£36.95")
    end
  end

  context "when 001, 002, 001, 003 are scanned" do
    it "calculates proper total price" do
      co = Checkout.new(promotional_rules)
      co.scan("001")
      co.scan("002")
      co.scan("001")
      co.scan("003")
      price = co.total

      expect(price).to eq("£73.76")
    end
  end
end
