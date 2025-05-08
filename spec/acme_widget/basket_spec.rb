require 'spec_helper'
require_relative '../../lib/acme_widget/models/product'
require_relative '../../lib/acme_widget/models/catalog'
require_relative '../../lib/acme_widget/models/delivery_rule'
require_relative '../../lib/acme_widget/services/delivery_calculator'
require_relative '../../lib/acme_widget/basket'

RSpec.describe AcmeWidget::Basket do
  let(:red_widget) { AcmeWidget::Product.new('R01', 32.95) }
  let(:green_widget) { AcmeWidget::Product.new('G01', 24.95) }
  let(:blue_widget) { AcmeWidget::Product.new('B01', 7.95) }
  let(:catalog) { AcmeWidget::Catalog.new([red_widget, green_widget, blue_widget]) }

  let(:delivery_rules) do
    [
      AcmeWidget::DeliveryRule.new(threshold: 90, charge: 0),
      AcmeWidget::DeliveryRule.new(threshold: 50, charge: 2.95),
      AcmeWidget::DeliveryRule.new(threshold: 0, charge: 4.95)
    ]
  end

  let(:delivery_calculator) { AcmeWidget::DeliveryCalculator.new(delivery_rules) }
  let(:basket) { AcmeWidget::Basket.new(catalog: catalog, delivery_calculator: delivery_calculator) }

  describe '#add' do
    it 'adds a product to the basket' do
      basket.add('R01')
      expect(basket.items).to include(red_widget)
    end

    it 'raises an error for invalid product code' do
      expect { basket.add('X99') }.to raise_error(ArgumentError)
    end
  end

  describe '#subtotal' do
    it 'returns the sum of all item prices' do
      basket.add('R01')
      basket.add('G01')
      expect(basket.subtotal).to eq(red_widget.price + green_widget.price)
    end
  end

  describe '#delivery_charge' do
    it 'calculates free delivery for orders $90 or more' do
      basket.add('R01')
      basket.add('R01')
      basket.add('G01')
      expect(basket.delivery_charge).to eq(0)
    end

    it 'calculates $2.95 delivery for orders between $50 and $89.99' do
      basket.add('R01')
      basket.add('G01')
      expect(basket.delivery_charge).to eq(2.95)
    end

    it 'calculates $4.95 delivery for orders under $50' do
      basket.add('B01')
      basket.add('G01')
      expect(basket.delivery_charge).to eq(4.95)
    end
  end

  describe '#total' do
    it 'includes the delivery charge in the total' do
      basket.add('B01')
      basket.add('G01')
      expect(basket.total).to eq(37.85)
    end
  end

  describe '#clear' do
    it 'removes all items from the basket' do
      basket.add('R01')
      basket.clear
      expect(basket.items).to be_empty
    end
  end
end
