# frozen_string_literal: true

module AcmeWidget
  module Config
    # Factory class that calculates the delivery charges with configured rules
    class DeliveryCalculatorFactory
      def self.build(config = Configuration)
        rules = config.delivery_rules['rules'].map do |rule_config|
          # TODO: fail gracefully by checking for malformed rules
          DeliveryRule.new(
            threshold: rule_config['threshold'],
            charge: rule_config['charge']
          )
        end
        DeliveryCalculator.new(rules)
      end
    end
  end
end
