# frozen_string_literal: true

module AcmeWidget
  class OfferCalculator
    def initialize(offers = [])
      @offers = offers
    end

    def calculate_discount(items)
      return 0 if items.empty?

      @offers.sum do |offer|
        offer.applicable?(items) ? offer.apply(items) : 0
      end
    end

    def add_offer(offer)
      @offers << offer
    end
  end
end
