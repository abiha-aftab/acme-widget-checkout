# frozen_string_literal: true

# Invoice class for printing the basket totals
class Invoice
    def initialize(io: $stdout)
      @io = io
    end
  
    def print(basket, title: nil)
      result = basket.total
  
      @io.puts "\n#{title}" if title
      @io.puts "\n------- Invoice -------"
      @io.puts "Product Name       | Code | Price"
      @io.puts "-------------------|------|--------"
  
      result[:items].each do |item|
        @io.puts "#{item[:name].ljust(19)}| #{item[:code]}  | $#{'%.2f' % item[:price]}"
      end
  
      @io.puts "-------------------|------|--------"
      @io.puts "Subtotal:                     $#{'%.f' % result[:subtotal]}"
      @io.puts "Delivery:                     $#{'%.2f' % result[:delivery]}"
      @io.puts "Discount:                     -$#{'%.2f' % result[:discount]}" if result[:discount].positive?
      @io.puts "Total:                        $#{'%.2f' % result[:total]}"
    end
  end
  