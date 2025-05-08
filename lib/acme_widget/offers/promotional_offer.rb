# frozen_string_literal: true

module AcmeWidget
  module PromotionalOffer
    def apply(items)
      raise NotImplementedError, "#{self.class.name} must implement 'apply'"
    end

    def applicable?(items)
      raise NotImplementedError, "#{self.class.name} must implement 'applicable?'"
    end
  end
end
