# frozen_string_literal: true

# Basket class for managing baskets
class Basket
  def initialize(products:, delivery_calculator:, offers:)
    @products = products
    @delivery_calculator = delivery_calculator
    @offers = offers
    @items = []
  end

  def add(product_code)
    product = @products.find { |p| p.code.casecmp?(product_code) }
    raise "Unknown Product: #{product_code}" unless product

    @items << product
  end

  def total
    original_total = @items.sum(&:price)
    discounted_items = calculate_discounted_items
    subtotal = discounted_items.sum(&:price)
    discount = original_total - subtotal
    delivery_fee = @delivery_calculator.delivery_charge(subtotal)

    build_summary(discounted_items, subtotal, discount, delivery_fee)
  end

  private

  def calculate_discounted_items
    @offers.inject(@items) { |items, offer| offer.apply(items) }
  end

  def build_summary(items, subtotal, discount, delivery_fee)
    {
      items: format_items(items),
      subtotal: subtotal,
      discount: discount,
      delivery: delivery_fee,
      total: (subtotal + delivery_fee).round(2)
    }
  end

  def format_items(items)
    items.map do |item|
      {
        name: item.name,
        code: item.code,
        price: item.price
      }
    end
  end
end
