class GenericTable::Dimension < ActiveRecord::Base
  attr_accessible :name

  has_many :aggregations
end
