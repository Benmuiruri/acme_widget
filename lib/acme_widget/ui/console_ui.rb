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

        products.each do |product|
          display_product_line(product)
        end

        display_separator('-')
      end

      def display_basket_summary(items_by_code, breakdown)
        display_formatted('=== BASKET SUMMARY ===')

        items_by_code.each do |code, items|
          display_basket_item(code, items)
        end

        display_price_breakdown(breakdown)
      end

      private

      def display_product_line(product)
        display_message("#{product.code} - #{product.code.sub(/\d+/, '')} Widget: #{format_currency(product.price)}")
      end

      def display_basket_item(code, items)
        product = items.first
        display_message("#{code} x#{items.size} - #{format_currency(product.price)} each")
      end

      def display_price_breakdown(breakdown)
        display_formatted('=== Price Breakdown ===')
        display_price_line('Subtotal', breakdown[:subtotal])

        if breakdown[:discount].positive?
          display_price_line('Discount', -breakdown[:discount])
          display_price_line('Subtotal after offers', breakdown[:subtotal_after_offers])
        end

        display_price_line('Delivery charge', breakdown[:delivery_charge])
        display_message('-------------------')
        display_price_line('TOTAL', breakdown[:total])
        display_message('====================')
      end

      def display_price_line(label, amount)
        display_message("#{label}: #{format_currency(amount.abs)}")
      end

      def format_currency(amount)
        "$#{format('%.2f', amount)}"
      end
    end
  end
end
