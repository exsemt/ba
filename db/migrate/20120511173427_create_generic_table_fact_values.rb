class CreateGenericTableFactValues < ActiveRecord::Migration
  def change
    create_table :generic_table_fact_values do |t|
      t.integer :group
      t.integer :dimension_value_id
      t.string :value

      t.timestamps
    end
  end
end
