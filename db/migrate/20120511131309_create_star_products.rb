class CreateStarProducts < ActiveRecord::Migration
  def change
    create_table :star_products do |t|
      t.integer :product_no
      t.string :name
      t.string :category
      t.string :brand
      t.string :contents
      t.float :price
    end
  end
end
