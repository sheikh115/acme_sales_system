# frozen_string_literal: true

# Abstract base class for all delivery rules
# This defines the interface for any delivery calculation
class DeliveryRule
  def initialize(rules)
    @rules = rules
  end

  # Calculate the delivery cost based on subtotal
  # Subclasses must implement this method
  def apply(subtotal)
    raise NotImplementedError
  end
end
