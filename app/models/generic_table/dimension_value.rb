class GenericTable::DimensionValue < ActiveRecord::Base
  attr_accessible :aggregation_id, :parent_id, :value

  belongs_to :aggregation
  has_many :fact_values
end
