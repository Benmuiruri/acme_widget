# frozen_string_literal: true

module AcmeWidget
  module Config
    # Factory class for building configured offers
    class OfferCalculatorFactory
      def self.build(catalog, conf = Configuration)
        offers = conf.offers['active'].map do |config|
          OfferFactory.create(config['type'].to_sym, config['product_code'], catalog)
        end
        OfferCalculator.new(offers)
      end
    end
  end
end
