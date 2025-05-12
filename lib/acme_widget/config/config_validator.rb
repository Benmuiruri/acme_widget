# frozen_string_literal: true

module AcmeWidget
  module Config
    class ConfigError < StandardError; end

    class ConfigurationValidator
      # Validates config.yml data structure
      def self.validate_offers(offers)
        raise ConfigError, "Missing or invalid 'offers' section in configuration" unless offers.is_a?(Hash)

        unless offers['mappings'].is_a?(Hash) && !offers['mappings'].empty?
          raise ConfigError, 'Missing or invalid offer mappings in configuration'
        end

        unless offers['active'].is_a?(Array) && !offers['active'].empty?
          raise ConfigError, 'Missing or invalid active offers in configuration'
        end

        offers['active'].each_with_index do |offer, index|
          validate_offer(offer, index, offers['mappings'])
        end

        offers
      end

      def self.validate_offer(offer, index, mappings)
        type = offer['type']
        product_code = offer['product_code']

        unless type.is_a?(String) && !type.empty?
          raise ConfigError,
                "Offer at index #{index} is missing a valid 'type'"
        end

        raise ConfigError, "Offer type '#{type}' has no mapping defined" unless mappings[type]

        return if product_code.is_a?(String) && !product_code.empty?

        raise ConfigError, "Offer at index #{index} is missing a valid 'product_code'"
      end

      def self.validate_delivery_rules(delivery_rules)
        unless delivery_rules.is_a?(Hash)
          raise ConfigError, "Missing or invalid 'delivery_rules' section in configuration"
        end

        unless delivery_rules['rules'].is_a?(Array) && !delivery_rules['rules'].empty?
          raise ConfigError, 'Missing or invalid delivery rules in configuration'
        end

        delivery_rules['rules'].each_with_index do |rule, index|
          raise ConfigError, "Delivery rule at index #{index} is not a hash" unless rule.is_a?(Hash)

          unless rule['threshold'].is_a?(Numeric)
            raise ConfigError, "Delivery rule at index #{index} is missing a valid 'threshold'"
          end

          unless rule['charge'].is_a?(Numeric)
            raise ConfigError, "Delivery rule at index #{index} is missing a valid 'charge'"
          end
        end

        unless delivery_rules['rules'].any? { |rule| rule['threshold'].zero? }
          raise ConfigError, 'Missing delivery rule for orders below minimum threshold (threshold: 0)'
        end

        delivery_rules
      end
    end
  end
end
