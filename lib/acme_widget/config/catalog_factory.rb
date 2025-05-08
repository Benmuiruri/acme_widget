# frozen_string_literal: true

module AcmeWidget
  module Config
    # Factory class for creating product catalog instances.
    class CatalogFactory
      def self.build
        # Products could be loaded from an external source (e.g. YAML)
        products = [
          Product.new('R01', 32.95),
          Product.new('G01', 24.95),
          Product.new('B01', 7.95)
        ]
        Catalog.new(products)
      end
    end
  end
end
