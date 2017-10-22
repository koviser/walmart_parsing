require 'app_helper'

RSpec.describe Api::Private::ProductsController, type: :controller do
  let(:response_data) { JSON.parse(response.body)['data'] }

  let(:product) { Fabricate(:product) }
  let(:reviews) {
    result = Fabricate.times(3, :review_with_assoc)
    result += Fabricate.times(3, :review_with_assoc, product: product)
    result
  }
  let(:default_params) {
    {
      format: :json,
      columns: { 0 => { search: { value: '' } } },
      order: { 0 => { column: 0 } },
      search: { value: '' },
    }
  }

  before { reviews }

  describe 'get #index' do
    let(:params) { default_params }

    context 'with json format' do
      it do
        get :index, params: params
        expect(response_data.count).to eq 4
      end
    end
  end

  describe 'post #create' do
    let(:params)        { { url: url} }
    let(:workers_count) { ParserProductWorker.jobs.count }

    context 'with valid url' do
      let(:url) { 'https://www.walmart.com/ip/Ematic-9-Dual-Screen-Portable-DVD-Player-with-Dual-DVD-Players-ED929D/28806789' }

      it do
        expect { post :create, params: params }.to change { Product.count }.by(1)
        expect(workers_count).to eq 1
      end
    end

    context 'with invalid url' do
      let(:url) { 'www.googlw.com' }

      it do
        expect { post :create, params: params }.to change { Product.count }.by(0)
        expect(workers_count).to eq 0
      end
    end
  end

  describe 'get #reviews' do
    let(:params) { default_params.merge(product_id: product.id) }

    context 'with json format' do
      it do
        get :reviews, params: params
        expect(response_data.count).to eq 3
      end
    end
  end
end
