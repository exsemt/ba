class AddIndexes < ActiveRecord::Migration
  def up
    add_index :generic_table_fact_values, :dimension_value_id, :name => 'index_dimension_value_id'
    add_index :generic_table_fact_values, :group, :name => 'index_group'
    add_index :generic_table_dimension_values, :parent_id, :name => 'index_parent_id'
    add_index :generic_table_dimension_values, :aggregation_id, :name => 'index_aggregation_id'
    add_index :generic_table_dimension_values, :value, :name => 'index_dimension_value'
    add_index :generic_table_aggregations, :name, :name => 'index_name'
  end

  def down
    remove_index :generic_table_fact_values, :name => :index_dimension_value_id
    remove_index :generic_table_fact_values, :name => :index_group
    remove_index :generic_table_dimension_values, :name => :index_parent_id
    remove_index :generic_table_dimension_values, :name => :index_aggregation_id
    remove_index :generic_table_dimension_values, :name => :index_dimension_value
    remove_index :generic_table_aggregations, :name => :index_name
  end
end


