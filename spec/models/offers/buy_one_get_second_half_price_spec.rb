# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/offers/buy_one_get_second_half_price'
require_relative '../../../lib/product'

RSpec.describe BuyOneGetSecondHalfPrice do
  let(:red_widget) { Product.new(code: 'R01', name: 'Red Widget', price: 32.95) }
  let(:blue_widget) { Product.new(code: 'B01', name: 'Blue Widget', price: 7.95) }
  let(:green_widget) { Product.new(code: 'G01', name: 'Green Widget', price: 10.50) }

  describe '#initialize' do
    context 'with invalid code' do
      it 'raises error with empty string' do
        expect { described_class.new('') }.to raise_error(ArgumentError, 'Product code must be a non-empty string')
      end

      it 'raises error with nil' do
        expect { described_class.new(nil) }.to raise_error(ArgumentError, 'Product code must be a non-empty string')
      end
    end
  end

  describe '#apply' do
    it 'applies half price to second item when there are two matching items' do
      offer = described_class.new('R01')
      result = offer.apply([red_widget, red_widget])

      expect(result.size).to eq(2)
      expect(result[0].price).to eq(32.95)
      expect(result[1].price).to eq(16.475)
    end

    it 'applies discount to pairs correctly with odd number of items' do
      offer = described_class.new('R01')
      result = offer.apply([red_widget, red_widget, red_widget])

      expect(result.size).to eq(3)
      expect(result[0].price).to eq(32.95)
      expect(result[1].price).to eq(16.475)
      expect(result[2].price).to eq(32.95)
    end

    it 'only applies discount to matching products, leaves others untouched' do
      offer = described_class.new('R01')
      result = offer.apply([red_widget, blue_widget, red_widget, green_widget])

      red_items = result.select { |item| item.code == 'R01' }
      blue_items = result.select { |item| item.code == 'B01' }
      green_items = result.select { |item| item.code == 'G01' }

      expect(red_items.size).to eq(2)
      expect(blue_items[0].price).to eq(7.95)
      expect(green_items[0].price).to eq(10.50)
    end

    it 'returns empty array when given empty array' do
      offer = described_class.new('R01')
      result = offer.apply([])

      expect(result).to eq([])
    end
  end
end
