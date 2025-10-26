# frozen_string_literal: true

# Product class for managing products
class Product
  attr_reader :code, :name, :price

  def initialize(code:, name:, price:)
    raise ArgumentError, 'Code must be present' if code.nil? || code.strip.empty?
    raise ArgumentError, 'Name must be present' if name.nil? || name.strip.empty?
    raise ArgumentError, 'Price must be a positive number' unless price.is_a?(Numeric) && price >= 0

    @code = code
    @name = name
    @price = price
  end
end
