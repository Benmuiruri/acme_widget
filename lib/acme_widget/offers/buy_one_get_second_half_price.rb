# frozen_string_literal: true

require_relative '../offers/promotional_offer'

module AcmeWidget
  # Promotional offer that applies a 50% discount to every second item of a specific product
  class BuyOneGetSecondHalfPrice
    include PromotionalOffer

    def initialize(product_code:, catalog:)
      @product_code = product_code
      @catalog = catalog
    end

    def apply(items)
      pairs = count_pairs(matching_items(items))
      return 0 if pairs.zero?

      pairs * discount_per_pair
    end

    def applicable?(items)
      matching_items(items).length >= 2
    end

    private

    def matching_items(items)
      items.select { |item| item.code == @product_code }
    end

    def count_pairs(items)
      items.length / 2
    end

    def discount_per_pair
      product = @catalog.find_by_code(@product_code)
      product.price / 2.0
    end
  end
end
