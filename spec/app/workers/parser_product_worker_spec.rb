require 'app_helper'

RSpec.describe ParserProductWorker do
  subject(:worker) { described_class }

  let(:product)    { Fabricate(:product, name: nil) }

  before { worker.perform_async(product.id) && worker.perform_one }
  describe 'check worker save real data' do
    it do
      expect(product.reload.name).not_to eq nil
      expect(product.reload.reviews.count.positive?).to eq true
    end
  end
end
