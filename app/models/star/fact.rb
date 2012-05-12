class Star::Fact < ActiveRecord::Base
  attr_accessible :branch_id, :commission, :customer_id, :date_id, :discount, :number, :product_id

  belongs_to :customer
  belongs_to :product
  belongs_to :branch
  belongs_to :date

end
