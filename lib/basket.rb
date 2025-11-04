# frozen_string_literal: true

# Basket represents a shopping basket for Acme Widget Co.
# It holds added products, applies offers, and calculates delivery cost.
# Only one offer can be applied on the basket.
# If no offer is passed then no offer will be applied
class Basket
  attr_reader :items, :product_catalogue, :delivery_rule, :offer

  def initialize(product_catalogue:, delivery_rule:, offer: nil)
    @product_catalogue = product_catalogue
    @delivery_rule = delivery_rule
    @offer = offer
    @items = []
  end

  def add(code)
    product = @product_catalogue.find_by_code(code)
    raise "Unknown product code: #{code}" unless product

    @items << product
  end

  def total
    subtotal = @items.sum(&:price)

    # Calculate total discount from offer, passing the items
    # set zero if no offer is present
    offer_discount = @offer ? @offer.apply(@items) : 0

    total = subtotal - offer_discount
    # Apply delivery rules to the discounted total
    delivery_cost = @delivery_rule.apply(total)
    (total + delivery_cost).round(2)
  end
end
