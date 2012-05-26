class SqlRequest < ActiveRecord::Base
  attr_accessible :finish, :payload, :server_id, :sql, :sql_duration, :start, :table_size
end
