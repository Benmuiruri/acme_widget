# frozen_string_literal: true

module AcmeWidget
  # Displays CLI menu and captures user input.
  class CLI
    def initialize(ui, basket_controller, catalog)
      @basket_controller = basket_controller
      @catalog = catalog
      @ui = ui
    end

    def run
      loop do
        display_menu
        choice = @ui.prompt('Select an option').downcase

        case choice
        when 'a' then add_product_to_basket
        when 'v' then @basket_controller.view_basket
        when 'c' then @basket_controller.clear_basket
        when 'p' then @ui.display_products(@catalog.all)
        when 'q' then break
        else
          @ui.display_message('Invalid option, please try again.')
        end
      end

      @ui.display_message("\nThank you for using Acme Widget Co Sales System!")
    end

    private

    def display_menu
      @ui.display_formatted('Menu Options:')
      menu_options = {
        'a' => 'Add product to basket',
        'v' => 'View basket details',
        'c' => 'Clear basket',
        'p' => 'View product catalog',
        'q' => 'Quit'
      }
      @ui.display_menu(menu_options)
    end

    def add_product_to_basket
      @ui.display_message("\nEnter product code(s) separated by commas (e.g., R01,G01):")
      input = @ui.prompt('')
      @basket_controller.add_products(input)
    end
  end
end
