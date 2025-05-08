# frozen_string_literal: true

module AcmeWidget
  # Initialises application components connecting user interface, business logic and data
  class Application
    attr_reader :basket_controller, :ui

    def initialize(ui = UI::ConsoleUI.new)
      @ui = ui
      setup_components
    end

    def run
      display_welcome
      CLI.new(self).run
    end

    def display_welcome
      @ui.display_welcome
    end

    private

    def setup_components
      catalog = Config::ApplicationSetup.create_catalog
      delivery_calculator = Config::ApplicationSetup.create_delivery_calculator
      offer_calculator = Config::ApplicationSetup.create_offer_calculator(catalog)

      basket = Config::ApplicationSetup.create_basket(
        catalog, delivery_calculator, offer_calculator
      )

      @basket_controller = Controllers::BasketController.new(basket, @ui)
    end
  end
end
