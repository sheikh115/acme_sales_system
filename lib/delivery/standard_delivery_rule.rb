# frozen_string_literal: true

require_relative 'delivery_rule'

# deliery/standard_delivery_rule.rb
class StandardDeliveryRule < DeliveryRule
  def apply(subtotal)
    # Find the first rule where subtotal falls within min..max
    rule = @rules.find do |r|
      subtotal >= r[:min] && (r[:max].nil? || subtotal < r[:max])
    end
    # Return the matching delivery cost, or 0 if no rule applies
    rule ? rule[:cost] : 0
  end
end
