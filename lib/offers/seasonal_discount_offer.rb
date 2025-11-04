# frozen_string_literal: true

require_relative 'offer'

# Applies a percentage discount to the basket subtotal.
# Example: 30% off seasonal sale.
#
# By injecting the percentage, the offer is reusable for
# Black Friday, Year-End, Summer Sale, etc.
class SeasonalDiscountOffer < Offer
	def initialize(percentage:)
		super
		@percentage = percentage
	end

  def apply(products)
    subtotal = products.sum(&:price)
		discount = subtotal * (@percentage / 100.0)
		discount.round(2)
  end
end
