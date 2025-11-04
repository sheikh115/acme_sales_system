# frozen_string_literal: true

require_relative 'test_helper'

class DeliveryRuleTest < Minitest::Test
  def setup
    @delivery_rule = standard_delivery_rule
  end

  def test_delivery_cost_below_first_tier
    assert_equal 4.95, @delivery_rule.apply(0)
    assert_equal 4.95, @delivery_rule.apply(25)
    assert_equal 4.95, @delivery_rule.apply(49.99)
  end

  def test_delivery_cost_middle_tier
    assert_equal 2.95, @delivery_rule.apply(50)
    assert_equal 2.95, @delivery_rule.apply(75)
    assert_equal 2.95, @delivery_rule.apply(89.99)
  end

  def test_delivery_cost_free_tier
    assert_equal 0, @delivery_rule.apply(90)
    assert_equal 0, @delivery_rule.apply(150)
  end

  def test_delivery_cost_no_match
    empty_rule = StandardDeliveryRule.new([])
    assert_equal 0, empty_rule.apply(10)
  end
end
