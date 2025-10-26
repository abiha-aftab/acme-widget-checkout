# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/delivery_calculator'
require_relative '../../lib/delivery_rule'

RSpec.describe DeliveryCalculator do
  let(:rules) do
    [
      DeliveryRule.new(threshold: 90, charge: 0),
      DeliveryRule.new(threshold: 50, charge: 2.95),
      DeliveryRule.new(threshold: 0, charge: 4.95)
    ]
  end

  let(:calculator) { DeliveryCalculator.new(rules) }

  it 'returns correct delivery charge based on subtotal' do
    expect(calculator.delivery_charge(100)).to eq(0.0)
    expect(calculator.delivery_charge(70)).to eq(2.95)
    expect(calculator.delivery_charge(30)).to eq(4.95)
  end

  it 'raises error for non-numeric subtotal' do
    expect { calculator.delivery_charge('twenty') }.to raise_error(ArgumentError)
  end

  it 'applies highest threshold rule when multiple match' do
    expect(calculator.delivery_charge(50)).to eq(2.95)
  end

  it 'returns zero charge for free delivery threshold' do
    expect(calculator.delivery_charge(90)).to eq(0.0)
    expect(calculator.delivery_charge(150)).to eq(0.0)
  end

  it 'raises error if rules are not DeliveryRule instances' do
    invalid_rules = [DeliveryRule.new(threshold: 50, charge: 2.95), 'invalid']
    expect { DeliveryCalculator.new(invalid_rules) }.to raise_error(ArgumentError)
  end
end
