class Star::Customer < ActiveRecord::Base
  attr_accessible :city, :country, :customer_no, :name, :postcode, :street_number, :type

  has_many :facts

end
