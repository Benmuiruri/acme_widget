# frozen_string_literal: true

module AcmeWidget
  class DeliveryRule
    attr_reader :threshold, :charge

    def initialize(threshold:, charge:)
      @threshold = threshold
      @charge = charge
    end
  end
end
