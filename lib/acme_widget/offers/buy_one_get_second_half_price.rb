# frozen_string_literal: true

require_relative '../offers/promotional_offer'

module AcmeWidget
  class BuyOneGetSecondHalfPrice
    include PromotionalOffer

    def initialize(product_code, catalog)
      @product_code = product_code
      @catalog = catalog
    end

    def apply(items)
      matching_items = items.select { |item| item.code == @product_code }
      pairs = matching_items.length / 2

      return 0 if pairs.zero?

      product = @catalog.find_by_code(@product_code)
      discount_per_pair = product.price / 2.0

      pairs * discount_per_pair
    end

    def applicable?(items)
      items.count { |item| item.code == @product_code } >= 2
    end
  end
end
