class GenericTablesController < ApplicationController

  def index
    @generic_table_dimensions       = GenericTable::Dimension.all
    @generic_table_aggregations     = GenericTable::Aggregation.all
    @generic_table_dimension_values = GenericTable::DimensionValue.all
    @generic_table_fact_values      = GenericTable::FactValue.all
  end

end
