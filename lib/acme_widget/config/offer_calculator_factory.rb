# frozen_string_literal: true

module AcmeWidget
  module Config
    # Factory class for building configured offers
    class OfferCalculatorFactory
      def self.build(catalog, conf = Configuration)
        offers = conf.offers['active'].map do |config|
          OfferFactory.create(
            type: config['type'].to_sym,
            product_code: config['product_code'],
            catalog: catalog
          )
        end
        OfferCalculator.new(offers)
      end
    end
  end
end
