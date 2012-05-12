class GenericTable::FactValue < ActiveRecord::Base
  attr_accessible :dimension_value_id, :group, :value

  belongs_to :dimension_value
end
