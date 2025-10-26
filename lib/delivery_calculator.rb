# frozen_string_literal: true

# DeliveryCalculator class for managing delivery charges
class DeliveryCalculator
  def initialize(rules)
    unless rules.all? { |r| r.is_a?(DeliveryRule) }
      raise ArgumentError, 'All delivery rules must be DeliveryRule instances'
    end

    @rules = rules.sort_by { |r| -r.threshold }
  end

  def delivery_charge(subtotal)
    raise ArgumentError, 'Subtotal must be numeric' unless subtotal.is_a?(Numeric)

    rule = @rules.find { |r| subtotal >= r.threshold }
    rule ? rule.charge : 0.0
  end
end
