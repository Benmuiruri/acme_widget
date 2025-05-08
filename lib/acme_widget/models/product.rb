# frozen_string_literal: true

module AcmeWidget
  # Model representing a product
  class Product
    attr_reader :code, :price

    def initialize(code, price)
      @code = code
      @price = price
    end
  end
end
