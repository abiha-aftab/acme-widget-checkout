# frozen_string_literal: true

# Invoice class for printing the basket totals
class Invoice
  def initialize(io: $stdout)
    @io = io
  end

  def print(basket, title: nil)
    result = basket.total
    print_header(title)
    print_items(result[:items])
    print_totals(result)
  end

  private

  def print_header(title)
    @io.puts "\n#{title}" if title
    @io.puts "\n------- Invoice -------"
    @io.puts 'Product Name       | Code | Price'
    @io.puts '-------------------|------|--------'
  end

  def print_items(items)
    items.each do |item|
      formatted_price = format('%.2f', item[:price])
      @io.puts "#{item[:name].ljust(19)}| #{item[:code]}  | $#{formatted_price}"
    end
  end

  def print_totals(result)
    @io.puts '-------------------|------|--------'
    @io.puts "Subtotal:                     $#{format('%.f', result[:subtotal])}"
    @io.puts "Delivery:                     $#{format('%.2f', result[:delivery])}"
    @io.puts "Discount:                     -$#{format('%.2f', result[:discount])}" if result[:discount].positive?
    @io.puts "Total:                        $#{format('%.2f', result[:total])}"
  end
end
