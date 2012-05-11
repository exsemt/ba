class Star::Product < ActiveRecord::Base
  attr_accessible :brand, :category, :contents, :name, :price, :product_no

  has_many :facts

end
