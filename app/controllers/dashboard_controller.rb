class DashboardController < ApplicationController

  def index
    @sql = SqlRequest.select(['name', 'table_size AS "StarFact table size"', 'avg(sql_duration)', 'GROUP_CONCAT(sql_duration)', 'substr(sql_query,1,50)']).
      group('name', 'table_size').order(:table_size).to_sql

    @db_response = ActiveRecord::Base.connection.select(@sql)

    @visualize_chart = SqlRequest.select(['name', 'table_size', 'avg(sql_duration) AS avg', 'GROUP_CONCAT(sql_duration)']).
      group('name', 'table_size').order(:table_size).group_by(&:table_size)
  end

end
