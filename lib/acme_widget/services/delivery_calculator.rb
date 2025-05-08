# frozen_string_literal: true

module AcmeWidget
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
