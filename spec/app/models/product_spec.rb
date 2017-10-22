require 'app_helper'

RSpec.describe Product do
  subject(:model) { described_class }

  let(:url)    { 'https://www.walmart.com/ip/Ematic-9-Dual-Screen-Portable-DVD-Player-with-Dual-DVD-Players-ED929D/28806789' }
  let(:params) { Fabricate.attributes_for(:product).merge(url: url) }

  let(:save_product) { model.create(params) }

  describe 'valid attributes' do
    context 'when save product' do
      it { expect { save_product }.to change { model.count }.by(1) }
    end

    context 'when update product' do
      before { save_product }

      let(:name) { 'test_name' }
      let(:update_product) { model[save_product.id].update(name: name) }

      it { expect(update_product).to eq true }
    end
  end

  describe 'wrong attributes' do
    context 'with invalid url' do
      let(:url) { 'www.googlw.com' }

      it do
        expect { save_product }.to change { model.count }.by(0)
        expect(save_product.errors.any?).to eq true
      end
    end
  end
end
