require 'open-uri'

class ParserProductWorker < BaseWorker
  def perform(id)
    @product = Product[id]
    return unless update_product
    update_reviews
  end

  private

  attr_reader :product

  def update_product
    product.update(product_hash)
  end

  def nokogiry_page
    @nokogiry_page ||= Nokogiri::HTML open(product.url).read
  end

  def redux_json
    return @redux_json if @redux_json

    redux_initial = "REDUX_INITIAL_STATE__ = "
    str_js = nokogiry_page
      .search('script').select do |data|
        data.text.include?('productAttributes') && data.text.include?(redux_initial)
      end.first.text

    index = str_js.index(redux_initial) + redux_initial.size
    @redux_json = JSON.parse str_js[index..-4]
    @redux_json
  end

  def update_reviews
    dd = nil
    ParserHost.new(product.product_id).reviews do |data|
      review = Review.find_by(product: product, review_id: data['reviewId'])
      next if review

      product.reviews << Review.new(review_hash(data))
    end
  end

  def review_hash(data)
    {
      author_id:       data['authorId'],
      rating:          data['rating'],
      review_id:       data['reviewId'],
      submission_time: data['reviewSubmissionTime'],
      text:            data['reviewText'],
      title:           data['reviewTitle'],
      user_nickname:   data['userNickname']
    }
  end

  def product_hash
    return @product_hash if @product_hash

    product_id      = redux_json['productBasicInfo']['selectedProductId']
    base_hash       = redux_json['productBasicInfo'][product_id]

    @product_hash = {
      name:               base_hash['title'],
      price:              redux_json['product']['midasContext']['price'],
      product_id:         product_id,
      us_item_id:         base_hash['usItemId'],
    }.merge(price_ranges)
  end

  def price_ranges
    price_range = redux_json['product']['priceRanges']
    return {} if price_range.blank?

    price_range = price_range.values.first
    {
      price_min:          price_range['minPrices']['CURRENT']['price'],
      price_min_currency: price_range['minPrices']['CURRENT']['currencyUnitSymbol'],
      price_max:          price_range['maxPrices']['CURRENT']['price'],
      price_max_currency: price_range['maxPrices']['CURRENT']['currencyUnitSymbol']
    }
  end
end
