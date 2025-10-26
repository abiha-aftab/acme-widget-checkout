# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/delivery_rule'

RSpec.describe DeliveryRule do
  it 'initializes with valid values' do
    rule = DeliveryRule.new(threshold: 50, charge: 2.95)
    expect(rule.threshold).to eq(50)
    expect(rule.charge).to eq(2.95)
  end

  it 'raises error if threshold is non-numeric' do
    expect do
      DeliveryRule.new(threshold: 'fifty', charge: 2.95)
    end.to raise_error(ArgumentError)
  end

  it 'raises error if charge is negative' do
    expect do
      DeliveryRule.new(threshold: 50, charge: -2.95)
    end.to raise_error(ArgumentError)
  end

  it 'accepts zero charge' do
    rule = DeliveryRule.new(threshold: 90, charge: 0.0)
    expect(rule.charge).to eq(0.0)
  end

  it 'accepts zero threshold' do
    rule = DeliveryRule.new(threshold: 0, charge: 4.95)
    expect(rule.threshold).to eq(0)
    expect(rule.charge).to eq(4.95)
  end

  it 'raises error if charge is non-numeric' do
    expect do
      DeliveryRule.new(threshold: 50, charge: 'free')
    end.to raise_error(ArgumentError)
  end
end
