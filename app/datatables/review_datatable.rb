require_dependency 'datatable'

class ReviewDatatable < DataTable
  private

  def data_class
    scope ? scope : Review
  end

  def sortable_columns
    @columns ||= %w[id title user_nickname text]
  end

  def searchable_columns
    @searchable ||= %w[id title user_nickname text]
  end

  def data
    records.map do |review|
      [
        review.id,
        review.title,
        review.user_nickname,
        review.text
      ]
    end
  end
end
