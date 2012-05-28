class DashboardController < ApplicationController

  def index
    @sql = SqlRequest.select(['name', 'table_size AS "StarFact table size"', 'avg(sql_duration)', 'GROUP_CONCAT(sql_duration)', 'sql_query']).
      group('name', 'table_size').order(:table_size).to_sql

    @db_response = ActiveRecord::Base.connection.select(@sql)
  end

end
