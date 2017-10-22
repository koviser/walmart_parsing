class Product < ApplicationRecord
  validates :url, presence: true
  validates :product_id, uniqueness: true
  validate :valid_url

  has_many :reviews

  def show_price
    if price_min && price_max
      "#{price_min} #{price_min_currency} - #{price_max} #{price_max_currency}"
    else
      price
    end
  end

  private

  def valid_url
    return if URI.parse(url.to_s).host.in? ParserHost::HOSTS
    errors.add(:url, "Url host is invalid")
  end
end
