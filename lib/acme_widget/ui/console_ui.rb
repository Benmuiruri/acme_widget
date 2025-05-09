# frozen_string_literal: true

module AcmeWidget
  module UI
    # Format the display
    class ConsoleUI
      def display_message(message)
        puts message
      end

      def display_formatted(message)
        puts "\n#{message}\n"
      end

      def prompt(message)
        print "#{message}: "
        gets.chomp
      end

      def display_menu(options)
        options.each do |key, description|
          puts "#{key} - #{description}"
        end
      end

      def display_separator(char = '-', length = 40)
        puts char * length
      end

      def display_welcome
        display_separator('=')
        display_message('Welcome to Acme Widget Co POS System')
        display_separator('=')
      end

      def display_products(products)
        display_formatted('Available Products:')
        display_separator('-')

        products.each do |code, name, price|
          display_message("#{code} - #{name}: #{format_currency(price)}")
        end

        display_separator('-')
      end

      def display_basket_summary(items_by_code, breakdown)
        display_formatted('=== BASKET SUMMARY ===')

        items_by_code.each do |code, items|
          product = items.first
          display_message("#{code} x#{items.size} - #{format_currency(product.price)} each")
        end

        display_formatted('=== Price Breakdown ===')
        display_message("Subtotal: #{format_currency(breakdown[:subtotal])}")

        if breakdown[:discount].positive?
          display_message("Discount:-#{format_currency(breakdown[:discount])}")
          display_message("Subtotal after offers: #{format_currency(breakdown[:subtotal_after_offers])}")
        end

        display_message("Delivery charge: #{format_currency(breakdown[:delivery_charge])}")
        display_message('-------------------')
        display_message("TOTAL: #{format_currency(breakdown[:total])}")
        display_message('====================')
      end

      private

      def format_currency(amount)
        "$#{format('%.2f', amount)}"
      end
    end
  end
end
