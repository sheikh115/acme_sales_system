# frozen_string_literal: true

require_relative 'offer'

# Offer that applies a "Buy One, Get Second Half Price" discount.
#  this is not locked to Red Widgets only, but now the product code is
# configurable via dependency injection. This makes the strategy reusable for
# any product — simply pass a different product_code when constructing the offer.
class BuyOneGetSecondHalfPriceOffer < Offer

  def initialize(product_code:)
    super
    @product_code = product_code
  end

  def apply(products)
    # Count how many widgets are in the basket
    eligible = products.select { |p| p.code == @product_code }
    return 0 if eligible.size < 2

    # For every 2 widgets, the second is half price
    pairs = eligible.size / 2
    # Fetch the price of widget
    product_price = eligible.first.price
    # Calculate total discount and round to 2 decimal places
    (pairs * (product_price / 2.0)).round(2)
  end
end
