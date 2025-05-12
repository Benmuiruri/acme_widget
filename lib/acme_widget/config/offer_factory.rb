# frozen_string_literal: true

module AcmeWidget
  module Config
    # Factory for applying specific offers to products
    class OfferFactory
      def self.create(type:, product_code:, catalog:, config: Configuration)
        class_name = config.offers['mappings'][type.to_s]
        raise ArgumentError, "Unknown offer type: #{type}" unless class_name

        Object.const_get("AcmeWidget::#{class_name}").new(product_code: product_code, catalog: catalog)
      end
    end
  end
end
