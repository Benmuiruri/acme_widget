# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/acme_widget/models/product'

RSpec.describe AcmeWidget::Product do
  describe '#initialize' do
    it 'creates a product with code and price' do
      product = AcmeWidget::Product.new('R01', 32.95)

      expect(product.code).to eq('R01')
      expect(product.price).to eq(32.95)
    end
  end
end
