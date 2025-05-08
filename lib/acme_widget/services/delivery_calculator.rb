# frozen_string_literal: true

module AcmeWidget
  # Calculates delivery charges based on order amount using threshold-based rules
  class DeliveryCalculator
    def initialize(rules)
      @rules = rules.sort_by(&:threshold).reverse
    end

    def calculate(amount)
      applicable_rule = @rules.find { |rule| amount >= rule.threshold }
      applicable_rule ? applicable_rule.charge : @rules.last.charge
    end
  end
end
