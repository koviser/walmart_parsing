module DatatablesHelper # rubocop:disable ModuleLength
  def products_datatable
    render_table(
      title: 'Products',
      data_path: api_private_products_path,
      show_path: products_path,
      headers: t_headers(:products)
    )
  end

  def reviews_datatable(product)
    render_table(
      title: 'Reviews',
      data_path: api_private_product_reviews_path(product),
      show_path: reviews_path,
      headers: t_headers(:reviews)
    )
  end

  def t_headers(table_name)
    headers.fetch(table_name).map { |h| t("activerecord.attributes.#{h}") }
  end

  def headers
    {
      products: %w[id name price],
      reviews:  %w[id reviewTitle userNickname reviewText]
    }
  end

  private

  def render_table(hash)
    render partial: 'datatables/table', locals: {
      rules: {},
      show_on_click: true,
      table_classes: '',
      show_new: true,
      show_path: hash[:data_path]
    }.merge(hash)
  end
end
