# frozen_string_literal: true

# Demonstrates basket functionality with offers and delivery charges

require_relative 'lib/product'
require_relative 'lib/delivery_rule'
require_relative 'lib/delivery_calculator'
require_relative 'lib/basket'
require_relative 'lib/invoice'
require_relative 'lib/offers/buy_one_get_second_half_price'

PRODUCTS = [
  Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
  Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
  Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
].freeze

DELIVERY_RULES = [
  DeliveryRule.new(threshold: 90, charge: 0.0),   # Free delivery for ≥ $90
  DeliveryRule.new(threshold: 50, charge: 2.95),  # $2.95 for ≥ $50 and < $90
  DeliveryRule.new(threshold: 0,  charge: 4.95)   # $4.95 for < $50
].freeze

OFFERS = [BuyOneGetSecondHalfPrice.new('R01')].freeze

DELIVERY_CALCULATOR = DeliveryCalculator.new(DELIVERY_RULES)
invoice = Invoice.new

demo_baskets = {
  %w[B01 G01] => 'Two different widgets',
  %w[R01 R01] => 'Two Red widgets (BOGO offer)',
  %w[R01 G01] => 'Red and Green widgets',
  %w[B01 B01 R01 R01 R01] => 'Multiple items with offers'
}

demo_baskets.each_with_index do |(product_codes, description), index|
  basket = Basket.new(
    products: PRODUCTS,
    delivery_calculator: DELIVERY_CALCULATOR,
    offers: OFFERS
  )

  product_codes.each { |code| basket.add(code) }

  invoice.print(basket, title: "=== Basket ##{index + 1}: #{description} ===")
end
