# frozen_string_literal: true

module AcmeWidget
  # Model representing product catalog
  class Catalog
    def initialize(products = [])
      @products = products
    end

    def find_by_code(code)
      @products.find { |product| product.code == code }
    end

    def all
      @products
    end
  end
end
