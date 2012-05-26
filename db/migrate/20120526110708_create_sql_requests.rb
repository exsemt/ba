class CreateSqlRequests < ActiveRecord::Migration
  def change
    create_table :sql_requests do |t|
      t.string :server_id
      t.datetime :start
      t.datetime :finish
      t.float :sql_duration
      t.text :sql
      t.text :payload
      t.integer :table_size

      t.timestamps
    end
  end
end
