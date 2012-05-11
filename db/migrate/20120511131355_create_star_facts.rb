class CreateStarFacts < ActiveRecord::Migration
  def change
    create_table :star_facts do |t|
      t.integer :customer_id
      t.integer :product_id
      t.integer :branch_id
      t.integer :date_id
      t.integer :number
      t.float :discount
      t.float :commission
    end
  end
end
