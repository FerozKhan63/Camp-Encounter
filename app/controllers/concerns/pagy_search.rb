module PagySearch
  extend ActiveSupport::Concern

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def pagy_sort_filter(query, klass)
    @records = klass.all
    @records = @records.order(sort_column + ' ' + sort_direction) if sort_column and sort_direction
    @records = @records.global_search(query).all if query.present?
    @pagy, @records = pagy(@records, items: 3)
  end
end
