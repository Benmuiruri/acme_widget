# frozen_string_literal: true

module AcmeWidget
  # Initialises application components connecting user interface, business logic and data
  class Application
    attr_reader :basket_controller, :ui, :catalog

    def initialize(ui: UI::ConsoleUI.new, interface: CLI, controller: Controllers::BasketController)
      @ui = ui
      @interface = interface
      @controller = controller
      setup_components
    end

    def run
      display_welcome
      cli.run
    end

    def display_welcome
      @ui.display_welcome
      @ui.display_products(@catalog.all)
    end

    private

    def cli
      @cli ||= @interface.new(@ui, @basket_controller, @catalog)
    end

    def setup_components
      @catalog = Config::ApplicationSetup.create_catalog
      delivery_calculator = Config::ApplicationSetup.create_delivery_calculator
      offer_calculator = Config::ApplicationSetup.create_offer_calculator(@catalog)

      basket = Config::ApplicationSetup.create_basket(
        @catalog, delivery_calculator, offer_calculator
      )

      @basket_controller = @controller.new(basket, @ui)
    end
  end
end
