# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/acme_widget'

RSpec.describe 'Acme Widget Integration' do
  it 'calculates the correct total in basket without discount' do
    catalog = AcmeWidget::Config::CatalogFactory.build
    delivery_calculator = AcmeWidget::Config::DeliveryCalculatorFactory.build
    offer_calculator = AcmeWidget::Config::OfferCalculatorFactory.build(catalog)

    basket = AcmeWidget::Basket.new(
      catalog: catalog,
      delivery_calculator: delivery_calculator,
      offer_calculator: offer_calculator
    )

    # Add products to basket
    basket.add('B01') # Blue Widget ($7.95)
    basket.add('G01') # Green Widget ($24.95)

    # Expected costs
    expected_subtotal = 7.95 + 24.95
    expected_discount = 0
    expected_delivery = 4.95
    expected_total = expected_subtotal + expected_delivery

    expect(basket.subtotal).to eq(expected_subtotal)
    expect(basket.discount).to eq(expected_discount)
    expect(basket.delivery_charge).to eq(expected_delivery)
    expect(basket.total).to eq(expected_total)
  end

  it 'calculates the correct total in basket with discount' do
    catalog = AcmeWidget::Config::CatalogFactory.build
    delivery_calculator = AcmeWidget::Config::DeliveryCalculatorFactory.build
    offer_calculator = AcmeWidget::Config::OfferCalculatorFactory.build(catalog)

    basket = AcmeWidget::Basket.new(
      catalog: catalog,
      delivery_calculator: delivery_calculator,
      offer_calculator: offer_calculator
    )

    # Add products to basket
    basket.add('R01') # Red Widget ($32.95)
    basket.add('R01') # Red Widget ($32.95)

    # Expected costs
    expected_subtotal = 32.95 + 32.95
    expected_discount = 32.95 / 2
    expected_delivery = 4.95
    expected_total = 54.37

    expect(basket.subtotal).to eq(expected_subtotal)
    expect(basket.discount).to eq(expected_discount)
    expect(basket.delivery_charge).to eq(expected_delivery)
    expect(basket.total).to eq(expected_total)
  end

  # TODO: Handle edge cases
end
