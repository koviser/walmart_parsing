class ParserHost
  HOST = 'www.walmart.com'.freeze
  HOSTS = [HOST, 'walmart.com']

  attr_reader :product_id, :next_page, :page

  def initialize(product_id)
    @product_id = product_id
    @page = 1
    @next_page = true
  end

  def reviews
    while next_page
      uri.query = URI.encode_www_form( params )
      response = JSON.parse(uri.open.read)
      response["payload"]["customerReviews"].each { |hash| yield(hash) }
      @page += 1
      @next_page = response["payload"]["pagination"]["next"].present?
    end
  end

  private

  def uri(type = 'reviews')
    @uri ||= URI "https://#{HOST}/terra-firma/item/#{product_id}/#{type}"
  end

  def params
    {
      filters:'',
      limit: '',
      page: page,
      sort: :relevancy
    }
  end
end
