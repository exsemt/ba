class CreateStarBranches < ActiveRecord::Migration
  def change
    create_table :star_branches do |t|
      t.integer :branch_no
      t.string :state
      t.string :city
      t.string :postcode
      t.string :street_number
    end
  end
end
