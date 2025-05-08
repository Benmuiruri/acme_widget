# frozen_string_literal: true

module AcmeWidget
  class Basket
    attr_reader :items

    def initialize(catalog:, delivery_calculator:)
      @catalog = catalog
      @delivery_calculator = delivery_calculator
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

    def delivery_charge
      @delivery_calculator.calculate(subtotal)
    end

    def total
      (subtotal + delivery_charge).round(2)
    end

    def clear
      @items = []
    end
  end
end
