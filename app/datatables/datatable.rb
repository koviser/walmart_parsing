class DataTable # rubocop:disable ClassLength
  delegate :params, :link_to, :content_tag, :policy, :current_user, :concat, :capture, to: :@view

  include Rails.application.routes.url_helpers

  def initialize(view, scope = nil)
    @view  = view
    @scope = scope
  end

  def as_json(_options = {})
    {
      draw: params[:draw].to_i,
      recordsTotal: cache_total_count,
      recordsFiltered: cache_empty_search_count,
      data: data
    }
  end

  private

  attr_reader :scope

  def data_class
    raise 'No model class specified'
  end

  def cache_total_count
    data_class.count
  end

  def cache_empty_search_count
    fetch_records.count
  end

  def records
    @records ||= fetch_records.order("#{sort_column} #{sort_order}").offset(offset).limit(limit)
  end

  def sort_column
    sortable_columns[params[:order]['0'][:column].to_i]
  end

  def sort_order
    params[:order]['0'][:dir]
  end

  def offset
    params[:start]
  end

  def search_value
    params[:search][:value]
  end

  def limit
    # if param is -1 => load all entries from DB
    params[:length] == '-1' ? nil : params[:length]
  end

  def sortable_columns
    # override to make sortable columns work. view order is important
    []
  end

  def searchable_columns
    # search is not working by default, override if model datatables to make it work
    []
  end

  def search_specific_column
    query = []
    params[:columns].each do |_, v|
      q = v['search']['value']
      next if q.blank?
      query << v['name'] << ' = ' << "'#{q}'"
    end
    query.join('')
  end

  def association_columns
    nil
  end

  def build_query # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    query = []
    q = search_value.split
    unless q.blank?
      q.each_with_index do |word, i|
        query << '('

        searchable_columns.each_with_index do |col, ii|
          query << 'OR' if ii != 0
          sanitized_string = "'%#{data_class.connection.quote_string(word)}%'"
          query << "cast(#{col} as text)" << 'ILIKE' << sanitized_string
        end

        query << ')'
        query << 'AND' if i < q.length - 1
      end
    end
    if !search_specific_column.blank?
      query.blank? ? search_specific_column : query.join(' ') << ' AND ' << search_specific_column
    else
      query.join(' ')
    end
  end

  def fetch_records
    if build_query.blank?
      return data_class.includes(association_columns).references(references_columns).all
    end
    data_class
      .includes(association_columns)
      .references(association_columns)
      .where(build_query)
  end

  def references_columns
    association_columns
  end
end
