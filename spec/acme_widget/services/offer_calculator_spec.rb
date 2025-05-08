# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/acme_widget/models/product'
require_relative '../../../lib/acme_widget/models/catalog'
require_relative '../../../lib/acme_widget/offers/buy_one_get_second_half_price'
require_relative '../../../lib/acme_widget/services/offer_calculator'

RSpec.describe AcmeWidget::OfferCalculator do
  let(:red_widget) { AcmeWidget::Product.new('R01', 32.95) }
  let(:catalog) { AcmeWidget::Catalog.new([red_widget]) }
  let(:offer) { AcmeWidget::BuyOneGetSecondHalfPrice.new('R01', catalog) }
  let(:calculator) { AcmeWidget::OfferCalculator.new([offer]) }

  describe '#calculate_discount' do
    it 'returns the sum of all applicable offers' do
      items = [red_widget, red_widget]
      expect(calculator.calculate_discount(items)).to eq(red_widget.price / 2)
    end

    it 'returns zero for empty items' do
      expect(calculator.calculate_discount([])).to eq(0)
    end

    it 'returns zero when no offers apply' do
      items = [red_widget]
      expect(calculator.calculate_discount(items)).to eq(0)
    end
  end

  describe '#add_offer' do
    it 'adds an offer to the calculator' do
      calculator = AcmeWidget::OfferCalculator.new
      calculator.add_offer(offer)

      items = [red_widget, red_widget]
      expect(calculator.calculate_discount(items)).to eq(red_widget.price / 2)
    end
  end
end
