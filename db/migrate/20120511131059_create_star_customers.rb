class CreateStarCustomers < ActiveRecord::Migration
  def change
    create_table :star_customers do |t|
      t.integer :customer_no
      t.string :name
      t.string :customer_type
      t.string :street_number
      t.string :city
      t.string :postcode
      t.string :country
    end
  end
end
