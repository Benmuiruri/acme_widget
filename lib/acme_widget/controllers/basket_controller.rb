# frozen_string_literal: true

module AcmeWidget
  module Controllers
    # Controller that manages interactions between the user interface and basket model.
    # Handles adding products, viewing basket contents, and clearing the basket
    class BasketController
      def initialize(basket, ui)
        @basket = basket
        @ui = ui
      end

      def add_products(input)
        codes = input.upcase.split(',').map(&:strip)

        codes.each do |code|
          product = @basket.add(code)
          @ui.display_message("Added #{product.code} to basket.")
        rescue ArgumentError => e
          @ui.display_message("Error: #{e.message}")
        end
      end

      def view_basket
        if @basket.items.empty?
          @ui.display_message("\nBasket is empty.")
          return
        end

        items_by_code = @basket.items.group_by(&:code)
        @ui.display_basket_summary(items_by_code, @basket.breakdown)
      end

      def clear_basket
        @basket.clear
        @ui.display_message("\nBasket cleared.")
      end
    end
  end
end
