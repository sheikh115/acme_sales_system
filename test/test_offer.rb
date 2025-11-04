# frozen_string_literal: true

require_relative 'test_helper'

class OfferTest < Minitest::Test
  def setup
    @product_catalogue = product_catalogue

    @offer1 = BuyOneGetSecondHalfPriceOffer.new(product_code: 'R01')
    @offer2 = SeasonalDiscountOffer.new(percentage: 10.0)


    @delivery_rule = standard_delivery_rule

    @red_widget_price = @product_catalogue.price_for('R01')
    @green_widget_price = @product_catalogue.price_for('G01')

    @basket1 = Basket.new(product_catalogue: @product_catalogue, delivery_rule: @delivery_rule, offer: @offer1)
    @basket2 = Basket.new(product_catalogue: @product_catalogue, delivery_rule: @delivery_rule, offer: @offer2)
  end

  def test_apply_offer_with_red_widgets
    # Add two red widgets to the basket
    2.times { @basket1.add('R01') }
    expected_discount = @red_widget_price / 2.0
    expected_total = (2 * @red_widget_price - expected_discount) + 4.95

    assert_in_delta expected_total, @basket1.total, 0.01
  end

  def test_apply_offer_with_no_red_widgets
    2.times { @basket1.add('G01') }

    # Since no red widgets are in the basket, no discount should apply
    expected_total = 2 * @green_widget_price + 4.95
    assert_in_delta expected_total, @basket1.total, 0.01
  end

  def test_apply_offer_with_less_than_two_red_widgets
    @basket1.add('R01')

    expected_total = @red_widget_price + 4.95
    assert_in_delta expected_total, @basket1.total, 0.01
  end

  def test_apply_ten_percent_discount
    2.times { @basket2.add('R01') }
  
    subtotal = @red_widget_price * 2
    discount = (subtotal * 0.10).round(2) 
    expected_total = (subtotal - discount) + 2.95
  
    assert_in_delta expected_total, @basket2.total
  end
end
