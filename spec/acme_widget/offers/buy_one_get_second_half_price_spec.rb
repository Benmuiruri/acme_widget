# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/acme_widget/models/product'
require_relative '../../../lib/acme_widget/models/catalog'
require_relative '../../../lib/acme_widget/offers/buy_one_get_second_half_price'

RSpec.describe AcmeWidget::BuyOneGetSecondHalfPrice do
  let(:red_widget) { AcmeWidget::Product.new('R01', 32.95) }
  let(:catalog) { AcmeWidget::Catalog.new([red_widget]) }
  let(:offer) { AcmeWidget::BuyOneGetSecondHalfPrice.new('R01', catalog) }

  describe '#applicable?' do
    it 'returns true when there are two or more of the product' do
      items = [red_widget, red_widget]
      expect(offer.applicable?(items)).to be true
    end

    it 'returns false when there is only one of the product' do
      items = [red_widget]
      expect(offer.applicable?(items)).to be false
    end
  end

  describe '#apply' do
    it 'applies half price to every second item' do
      items = [red_widget, red_widget]
      expect(offer.apply(items)).to eq(red_widget.price / 2)
    end

    it 'applies discount to multiple pairs' do
      items = [red_widget, red_widget, red_widget, red_widget]
      expect(offer.apply(items)).to eq(red_widget.price)
    end

    it 'returns zero if no pairs exist' do
      items = [red_widget]
      expect(offer.apply(items)).to eq(0)
    end
  end
end
