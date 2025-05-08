# frozen_string_literal: true

module AcmeWidget
  module Config
    # Factory class to configure products, delivery rules and promotional offers.
    class ApplicationSetup
      def self.create_catalog
        CatalogFactory.build
      end

      def self.create_delivery_calculator
        DeliveryCalculatorFactory.build
      end

      def self.create_offer_calculator(catalog)
        OfferCalculatorFactory.build(catalog)
      end

      def self.create_basket(catalog, delivery_calc, offer_calc)
        Basket.new(
          catalog: catalog,
          delivery_calculator: delivery_calc,
          offer_calculator: offer_calc
        )
      end
    end
  end
end
