# frozen_string_literal: true

# DeliveryRule class for managing delivery rules
class DeliveryRule
  attr_reader :threshold, :charge

  def initialize(threshold:, charge:)
    raise ArgumentError, 'Threshold must be numeric' unless threshold.is_a?(Numeric)
    raise ArgumentError, 'Charge must be non-negative' unless charge.is_a?(Numeric) && charge >= 0

    @threshold = threshold
    @charge = charge
  end
end
