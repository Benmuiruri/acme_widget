# frozen_string_literal: true

module AcmeWidget
  # Model representing delivery rule
  class DeliveryRule
    attr_reader :threshold, :charge

    def initialize(threshold:, charge:)
      @threshold = threshold
      @charge = charge
    end
  end
end
