# frozen_string_literal: true

module AcmeWidget
  # Model representing customer's shopping basket manages product items
  # calculates pricing including subtotals, promotional discounts, and delivery charges.
  class Basket
    attr_reader :items

    def initialize(catalog:, delivery_calculator:, offer_calculator: nil)
      @catalog = catalog
      @delivery_calculator = delivery_calculator
      @offer_calculator = offer_calculator
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

    def discount
      return 0 unless @offer_calculator

      @offer_calculator.calculate_discount(@items)
    end

    def delivery_charge
      @delivery_calculator.calculate(subtotal - discount)
    end

    def total
      ((subtotal - discount + delivery_charge) * 100).floor / 100.0
    end

    def clear
      @items = []
    end

    def empty?
      @items.empty?
    end

    def grouped_items
      @items.group_by(&:code)
    end

    def breakdown
      {
        items: @items.map(&:code),
        subtotal: subtotal,
        discount: discount,
        subtotal_after_offers: subtotal - discount,
        delivery_charge: delivery_charge,
        total: total
      }
    end
  end
end
