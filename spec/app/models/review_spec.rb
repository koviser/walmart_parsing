require 'app_helper'

RSpec.describe Review do
  subject(:model) { described_class }

  let(:review_id)   { Faker::Name.name }
  let(:params)      { Fabricate.attributes_for(:review_with_assoc).merge(review_id: review_id) }
  let(:save_review) { model.create(params) }

  describe 'valid attributes' do
    context 'when save review' do
      it { expect { save_review }.to change { model.count }.by(1) }
    end

    context 'when update review' do
      before { save_review }

      let(:title) { 'test title' }
      let(:update_review) { model[save_review.id].update(title: title) }

      it { expect(update_review).to eq true }
    end
  end

  describe 'wrong attributes' do
    context 'with invalid review_id' do
      let(:review_id) { nil }

      it do
        expect { save_review }.to change { model.count }.by(0)
        expect(save_review.errors.any?).to eq true
      end
    end
  end
end
