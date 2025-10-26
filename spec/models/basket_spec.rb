# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/basket'
require_relative '../../lib/product'
require_relative '../../lib/delivery_calculator'
require_relative '../../lib/delivery_rule'
require_relative '../../lib/offers/buy_one_get_second_half_price'

RSpec.describe Basket do
  let(:catalog) do
    [
      Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
      Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
      Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
    ]
  end

  let(:rules) do
    [
      DeliveryRule.new(threshold: 90, charge: 0),
      DeliveryRule.new(threshold: 50, charge: 2.95),
      DeliveryRule.new(threshold: 0, charge: 4.95)
    ]
  end

  let(:delivery_calculator) { DeliveryCalculator.new(rules) }
  let(:offers) { [BuyOneGetSecondHalfPrice.new('R01')] }

  it 'adds items and calculates totals correctly' do
    basket = Basket.new(products: catalog, delivery_calculator: delivery_calculator, offers: offers)
    basket.add('R01')
    basket.add('R01')
    totals = basket.total

    expect(totals[:subtotal]).to eq(32.95 + 16.475)
    expect(totals[:delivery]).to eq(4.95)
    expect(totals[:total]).to eq(54.38)
  end

  it 'raises when adding unknown product' do
    basket = Basket.new(products: catalog, delivery_calculator: delivery_calculator, offers: [])
    expect { basket.add('unknown') }.to raise_error('Unknown Product: unknown')
  end
end
