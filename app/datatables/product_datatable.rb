require_dependency 'datatable'

class ProductDatatable < DataTable
  private

  def data_class
    scope ? scope : Product
  end

  def sortable_columns
    @columns ||= %w[id name price]
  end

  def searchable_columns
    @searchable ||= %w[id name price]
  end

  def data
    records.map do |product|
      [
        product.id,
        product.name,
        product.show_price
      ]
    end
  end
end
