module AcmeWidget
  class DeliveryRule
    attr_reader :threshold, :charge

    def initialize(threshold:, charge:)
      @threshold = threshold
      @charge = charge
    end
  end
end
