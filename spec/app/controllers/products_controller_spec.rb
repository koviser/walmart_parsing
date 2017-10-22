require 'app_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'get #index' do
    context 'with html format' do
      let(:params) { Hash.new }

      it do
        get :index, params: params
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'get #show' do
    context 'with html format' do
      let(:product) { Fabricate(:product) }
      let(:params)  { { id: product.id } }

      it do
        get :show, params: params
        expect(response).to render_template(:show)
      end
    end
  end
end
