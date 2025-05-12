# frozen_string_literal: true

require 'yaml'

module AcmeWidget
  module Config
    # Loads the offers config and can also load delivery rules yaml
    class Configuration
      CONFIG_FILE = 'config.yml'

      def self.load_file(filename)
        file_path = File.join(File.dirname(__FILE__), filename)
        begin
          YAML.load_file(file_path)
        rescue Errno::ENOENT
          warn "Warning: Configuration file '#{filename}' not found"
          {}
        rescue StandardError => e
          warn "Error loading '#{filename}': #{e.message}, using defaults"
          {}
        end
      end

      def self.offers
        config = load_file(CONFIG_FILE)
        ConfigurationValidator.validate_offers(config['offers'] || {})
      end

      def self.delivery_rules
        config = load_file(CONFIG_FILE)
        ConfigurationValidator.validate_delivery_rules(config['delivery_rules'] || {})
      end
    end
  end
end
