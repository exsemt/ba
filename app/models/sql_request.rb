class SqlRequest < ActiveRecord::Base
  attr_accessible :finish, :payload, :server_id, :sql_query, :sql_duration, :start, :table_size
end
