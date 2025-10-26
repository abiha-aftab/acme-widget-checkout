# frozen_string_literal: true

require_relative '../offer'

class BuyOneGetSecondHalfPrice < Offer
  def initialize(target_code)
    unless target_code.is_a?(String) && !target_code.strip.empty?
      raise ArgumentError,
            'Product code must be a non-empty string'
    end

    @target_code = target_code
  end

  def apply(items)
    matched, others = items.partition { |item| item.code == @target_code }
    discounted_items = apply_discount_to_matched(matched)
    discounted_items + others
  end

  private

  def apply_discount_to_matched(matched)
    discounted = []
    matched.each_slice(2) do |first, second|
      discounted << first
      next unless second

      discounted << create_discounted_product(second)
    end
    discounted
  end

  def create_discounted_product(product)
    Product.new(
      code: product.code,
      name: product.name,
      price: (product.price / 2.0)
    )
  end
end
