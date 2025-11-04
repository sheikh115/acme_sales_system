# frozen_string_literal: true

# Load Minitest and any supporting libraries
require 'minitest/autorun'

# Add lib to the load path
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

# Require all the classes
require 'pry'
require 'product'
require 'basket'
require 'catalogue'
require 'offers/buy_one_get_second_half_price'
require 'offers/seasonal_discount_offer'
require 'delivery/standard_delivery_rule'

def product_catalogue
  Catalogue.new([
                  Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
                  Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
                  Product.new(code: 'B01', name: 'Blue Widget',  price: 7.95)
                ])
end

def standard_delivery_rule
  StandardDeliveryRule.new([
                             { min: 0, max: 50, cost: 4.95 },
                             { min: 50, max: 90, cost: 2.95 },
                             { min: 90, max: nil, cost: 0 }
                           ])
end
