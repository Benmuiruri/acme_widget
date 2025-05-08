# frozen_string_literal: true

module AcmeWidget
  class Basket
    attr_reader :items

    def initialize(catalog:)
      @catalog = catalog
      @items = []
    end

    def add(product_code)
      product = @catalog.find_by_code(product_code)
      raise ArgumentError, "Product not found: #{product_code}" unless product

      @items << product
      product
    end

    def subtotal
      @items.sum(&:price)
    end

    def total
      subtotal
    end

    def clear
      @items = []
    end
  end
end
