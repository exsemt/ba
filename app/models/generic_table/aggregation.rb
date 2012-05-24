class GenericTable::Aggregation < ActiveRecord::Base
  attr_accessible :dimension_id, :name, :parent_id

  belongs_to :dimension
  has_many :dimension_values
  belongs_to :aggregation, :foreign_key => :parent_id

end
