# frozen_string_literal: true

# Abstract offer interface
class Offer
  # Apply this offer to a set of products
  def initialize(**_args); end
  
  def apply(products)
    raise NotImplementedError, "#{self.class} must implement #apply"
  end
end
