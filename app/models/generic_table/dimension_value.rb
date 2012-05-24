class GenericTable::DimensionValue < ActiveRecord::Base
  attr_accessible :aggregation_id, :parent_id, :value

  belongs_to :aggregation
  has_many :fact_values
  belongs_to :dimension_value, :foreign_key => :parent_id

end
