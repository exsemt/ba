class CreateGenericTableAggregations < ActiveRecord::Migration
  def change
    create_table :generic_table_aggregations do |t|
      t.string :name
      t.integer :dimension_id
      t.integer :parent_id
    end
  end
end
