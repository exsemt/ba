class Star::Branch < ActiveRecord::Base
  attr_accessible :branch_no, :city, :postcode, :state, :street_number

  has_many :facts

end
