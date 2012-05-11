class Star::Date < ActiveRecord::Base
  attr_accessible :day, :month, :quarter, :year

  has_many :facts

end
