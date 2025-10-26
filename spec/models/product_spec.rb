# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/product'

RSpec.describe Product do
  it 'initializes with valid attributes' do
    product = Product.new(code: 'A01', name: 'Test Product', price: 10.0)
    expect(product.code).to eq('A01')
    expect(product.name).to eq('Test Product')
    expect(product.price).to eq(10.0)
  end

  it 'raises error with blank code' do
    expect do
      Product.new(code: '', name: 'Product', price: 5)
    end.to raise_error(ArgumentError)
  end

  it 'raises error with blank name' do
    expect do
      Product.new(code: 'A01', name: '', price: 5)
    end.to raise_error(ArgumentError)
  end

  it 'raises error with negative price' do
    expect do
      Product.new(code: 'A01', name: 'Product', price: -5)
    end.to raise_error(ArgumentError)
  end
end
