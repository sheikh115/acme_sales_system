# frozen_string_literal: true

# lib/catalogue.rb
class Catalogue
  def initialize(products = [])
    @products = products.to_h { |p| [p.code, p] }
  end

  def find_by_code(code)
    @products[code]
  end

  def price_for(code)
    product = find_by_code(code)
    product.price
  end
end
