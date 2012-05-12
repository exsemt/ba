class CreateGenericTableDimensionValues < ActiveRecord::Migration
  def change
    create_table :generic_table_dimension_values do |t|
      t.integer :aggregation_id
      t.integer :parent_id
      t.string :value

      t.timestamps
    end
  end
end
