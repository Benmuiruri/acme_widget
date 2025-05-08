# frozen_string_literal: true

# Main entry file for the Acme Widget Co Sales System.

require_relative 'acme_widget/models/product'
require_relative 'acme_widget/models/catalog'
require_relative 'acme_widget/models/delivery_rule'
require_relative 'acme_widget/basket'

require_relative 'acme_widget/services/delivery_calculator'
require_relative 'acme_widget/services/offer_calculator'

require_relative 'acme_widget/offers/promotional_offer'
require_relative 'acme_widget/offers/buy_one_get_second_half_price'

require_relative 'acme_widget/ui/console_ui'
require_relative 'acme_widget/controllers/basket_controller'
require_relative 'acme_widget/config/application_setup'
require_relative 'acme_widget/config/catalog_factory'
require_relative 'acme_widget/config/delivery_calculator_factory'
require_relative 'acme_widget/config/offer_calculator_factory'
require_relative 'acme_widget/config/configuration'
require_relative 'acme_widget/config/offer_factory'
require_relative 'acme_widget/application'
require_relative 'acme_widget/cli'

# Main entry point into the Acme Widget POS System.
module AcmeWidget
  def self.start
    Application.new.run
  end
end
