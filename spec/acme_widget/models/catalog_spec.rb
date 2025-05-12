# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/acme_widget/models/product'
require_relative '../../../lib/acme_widget/models/catalog'

RSpec.describe AcmeWidget::Catalog do
  let(:red_widget) { AcmeWidget::Product.new(code: 'R01', price: 32.95) }
  let(:green_widget) { AcmeWidget::Product.new(code: 'G01', price: 24.95) }
  let(:catalog) { AcmeWidget::Catalog.new([red_widget, green_widget]) }

  describe '#find_by_code' do
    it 'returns the product with the matching code' do
      expect(catalog.find_by_code('R01')).to eq(red_widget)
    end

    it 'returns nil if no product matches' do
      expect(catalog.find_by_code('B01')).to be_nil
    end
  end

  describe '#all' do
    it 'returns all products' do
      expect(catalog.all).to contain_exactly(red_widget, green_widget)
    end
  end
end
