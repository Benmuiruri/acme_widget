# frozen_string_literal: true

module AcmeWidget
  # Interface for promotional offers. It defines the contract all offer types must implement for discount calculation.
  module PromotionalOffer
    def apply(items)
      raise NotImplementedError, "#{self.class.name} must implement 'apply'"
    end

    def applicable?(items)
      raise NotImplementedError, "#{self.class.name} must implement 'applicable?'"
    end
  end
end
