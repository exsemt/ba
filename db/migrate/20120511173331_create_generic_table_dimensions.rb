class CreateGenericTableDimensions < ActiveRecord::Migration
  def change
    create_table :generic_table_dimensions do |t|
      t.string :name

      t.timestamps
    end
  end
end
