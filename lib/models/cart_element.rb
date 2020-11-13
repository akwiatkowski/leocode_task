class CartElement
  def initialize(product)
    @product = product
    @cart_price = @product.price
  end

  attr_reader :cart_price

  # different name of writer should reduce bugs
  def update_cart_price(new_cart_price)
    @cart_price = new_cart_price
  end

  # XXX would be nice to use active support delegate
  # https://blog.lelonek.me/how-to-delegate-methods-in-ruby-a7a71b077d99
  # delegate :price, :name, :code, to: :product

  def price
    @product.price
  end

  def name
    @product.name
  end

  def code
    @product.code
  end
end
