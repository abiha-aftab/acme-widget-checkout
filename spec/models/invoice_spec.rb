# frozen_string_literal: true

require 'spec_helper'
require 'stringio'
require_relative '../../lib/invoice'
require_relative '../../lib/product'
require_relative '../../lib/delivery_calculator'
require_relative '../../lib/delivery_rule'
require_relative '../../lib/basket'

RSpec.describe Invoice do
  let(:io) { StringIO.new }
  let(:invoice) { described_class.new(io: io) }
  let(:products) { [Product.new(code: 'R01', name: 'Red Widget', price: 32.95)] }
  let(:delivery_rule) { DeliveryRule.new(threshold: 50, charge: 10.0) }
  let(:delivery_calculator) { DeliveryCalculator.new([delivery_rule]) }
  let(:basket) do
    Basket.new(
      products: products,
      delivery_calculator: delivery_calculator,
      offers: []
    )
  end

  describe '#print' do
    it 'prints invoice with header, products, and totals' do
      basket.add('R01')
      invoice.print(basket)

      output = io.string
      expect(output).to include('------- Invoice -------')
      expect(output).to include('Red Widget')
      expect(output).to include('Subtotal:')
      expect(output).to include('Total:')
    end

    it 'prints optional title when provided' do
      basket.add('R01')
      invoice.print(basket, title: 'Order #123')

      output = io.string
      expect(output).to include('Order #123')
    end
  end
end
