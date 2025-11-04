# frozen_string_literal: true

$LOAD_PATH << './lib'
require 'product'
require 'catalogue'
require 'basket'
require 'offers/buy_one_get_second_half_price'
require 'delivery/standard_delivery_rule'

product_catalogue = Catalogue.new([
                                    Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
                                    Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
                                    Product.new(code: 'B01', name: 'Blue Widget',  price: 7.95)
                                  ])

delivery_rule = StandardDeliveryRule.new([
                                           { min: 0, max: 50, cost: 4.95 },
                                           { min: 50, max: 90, cost: 2.95 },
                                           { min: 90, max: nil, cost: 0 }
                                         ])

offer = BuyOneGetSecondHalfPriceOffer.new(product_code: 'R01')

basket = Basket.new(
  product_catalogue: product_catalogue,
  delivery_rule: delivery_rule,
  offer: offer
)

basket.add('B01')
basket.add('G01')
puts 'Basket: B01, G01'
puts 'Expected Total: $37.85'
puts "Calculated Total: $#{basket.total}\n\n"

basket = Basket.new(
  product_catalogue: product_catalogue,
  delivery_rule: delivery_rule,
  offer: offer
)
basket.add('R01')
basket.add('R01')
puts 'Basket: R01, R01'
puts 'Expected Total: $54.37'
puts "Calculated Total: $#{basket.total}\n\n"

# Test 3: R01, G01
basket = Basket.new(
  product_catalogue: product_catalogue,
  delivery_rule: delivery_rule,
  offer: offer
)
basket.add('R01')
basket.add('G01')
puts 'Basket: R01, G01'
puts 'Expected Total: $60.85'
puts "Calculated Total: $#{basket.total}\n\n"

basket = Basket.new(
  product_catalogue: product_catalogue,
  delivery_rule: delivery_rule,
  offer: offer
)
basket.add('B01')
basket.add('B01')
basket.add('R01')
basket.add('R01')
basket.add('R01')
puts 'Basket: B01, B01, R01, R01, R01'
puts 'Expected Total: $98.27'
puts "Calculated Total: $#{basket.total}\n\n"
