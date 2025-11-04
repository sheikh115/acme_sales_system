# frozen_string_literal: true

require_relative 'test_helper'

# test/test_basket.rb
class BasketTest < Minitest::Test
  def setup
    @product_catalogue = product_catalogue

    @delivery_rule = standard_delivery_rule

    @offer = BuyOneGetSecondHalfPriceOffer.new(product_code: 'R01')

    @basket = Basket.new(product_catalogue: @product_catalogue, delivery_rule: @delivery_rule, offer: @offer)
    @no_offer_basket = Basket.new(product_catalogue: @product_catalogue, delivery_rule: @delivery_rule, offer: nil)
  end

  def test_add_product
    @basket.add('R01')
    @basket.add('G01')
    assert_equal 2, @basket.items.count
  end

  def test_add_non_existent_product
    assert_raises(RuntimeError, 'Unknown product code: Z01') do
      @basket.add('Z01')
    end
    assert_equal 0, @basket.items.count
  end

  def test_total_with_no_offer
    @basket.add('G01')
    assert_in_delta 24.95 + 4.95, @basket.total, 0.01
  end

  def test_total_with_red_widget_offer
    2.times { @basket.add('R01') }
    expected_discount = 32.95 / 2.0
    expected_total = (32.95 * 2 - expected_discount) + 4.95
    assert_in_delta expected_total, @basket.total, 0.01
  end

  def test_calculate_total_without_offer
    2.times { @no_offer_basket.add('R01') }
    expected_discount = 0.0
    expected_total = (32.95 * 2 - expected_discount) + 2.95
    assert_in_delta expected_total, @no_offer_basket.total, 0.01
  end
end
