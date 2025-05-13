# frozen_string_literal: true

module AcmeWidget
  # Calculates delivery charges based on order amount using threshold-based rules
  class DeliveryCalculator
    def initialize(rules)
      @rules = rules.sort_by(&:threshold).reverse
    end

    def calculate(amount)
      applicable_rule = find_applicable_rule(amount)
      applicable_rule.charge
    end

    private

    def find_applicable_rule(amount)
      @rules.find { |rule| amount >= rule.threshold } || @rules.last
    end
  end
end
