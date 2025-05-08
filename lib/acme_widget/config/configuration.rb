# frozen_string_literal: true

require 'yaml'

module AcmeWidget
  module Config
    # Loads the offers config and can also load delivery rules
    class Configuration
      def self.load_file(filename)
        file_path = File.join(File.dirname(__FILE__), filename)
        begin
          YAML.load_file(file_path)
        rescue Errno::ENOENT
          warn "Warning: Configuration file '#{filename}' not found, using defaults"
          {}
        rescue StandardError => e
          warn "Error loading '#{filename}': #{e.message}, using defaults"
          {}
        end
      end

      def self.offers
        @offers ||= load_file('offers.yml')['offers']
      end

      def self.delivery_rules
        # This can also be a YAML
        @delivery_rules ||= {
          'rules' => [
            { 'threshold' => 90, 'charge' => 0 },
            { 'threshold' => 50, 'charge' => 2.95 },
            { 'threshold' => 0, 'charge' => 4.95 }
          ]
        }
      end
    end
  end
end
