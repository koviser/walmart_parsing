require 'app_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'get #show' do
    context 'with html format' do
      let(:review) { Fabricate(:review_with_assoc) }
      let(:params) { { id: review.id } }

      it do
        get :show, params: params
        expect(response).to render_template(:show)
      end
    end
  end
end
