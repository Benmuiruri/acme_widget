# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/acme_widget/models/product'
require_relative '../../../lib/acme_widget/models/catalog'
require_relative '../../../lib/acme_widget/models/delivery_rule'
require_relative '../../../lib/acme_widget/services/delivery_calculator'
require_relative '../../../lib/acme_widget/models/basket'

RSpec.describe AcmeWidget::Basket do
  let(:red_widget) { AcmeWidget::Product.new(code: 'R01', price: 32.95) }
  let(:green_widget) { AcmeWidget::Product.new(code: 'G01', price: 24.95) }
  let(:blue_widget) { AcmeWidget::Product.new(code: 'B01', price: 7.95) }
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

  describe '#discount' do
    it 'returns zero when no offer calculator is provided' do
      basket_without_offers = AcmeWidget::Basket.new(
        catalog: catalog,
        delivery_calculator: delivery_calculator
      )
      basket_without_offers.add('R01')
      expect(basket_without_offers.discount).to eq(0)
    end

    it 'calculates discount when offer calculator is provided' do
      offer = AcmeWidget::BuyOneGetSecondHalfPrice.new(product_code: 'R01', catalog: catalog)
      offer_calculator = AcmeWidget::OfferCalculator.new([offer])

      basket_with_offers = AcmeWidget::Basket.new(
        catalog: catalog,
        delivery_calculator: delivery_calculator,
        offer_calculator: offer_calculator
      )

      basket_with_offers.add('R01')
      basket_with_offers.add('R01')

      expected_discount = red_widget.price / 2.0
      expect(basket_with_offers.discount).to eq(expected_discount)
    end
  end

  describe '#total' do
    it 'includes discounts and delivery in the total' do
      offer = AcmeWidget::BuyOneGetSecondHalfPrice.new(product_code: 'R01', catalog: catalog)
      offer_calculator = AcmeWidget::OfferCalculator.new([offer])

      basket_with_offers = AcmeWidget::Basket.new(
        catalog: catalog,
        delivery_calculator: delivery_calculator,
        offer_calculator: offer_calculator
      )

      basket_with_offers.add('R01')
      basket_with_offers.add('R01')

      subtotal = red_widget.price * 2
      discount = red_widget.price / 2.0
      delivery = 4.95

      expected_total = ((subtotal - discount + delivery) * 100).floor / 100.0
      expect(basket_with_offers.total).to eq(expected_total)
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
