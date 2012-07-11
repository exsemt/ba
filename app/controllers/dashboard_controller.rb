class DashboardController < ApplicationController

  def index
    @sql = SqlRequest.select(['name', 'table_size AS "StarFact table size"', 'avg(sql_duration)', 'GROUP_CONCAT(sql_duration SEPARATOR ", ")', 'substr(sql_query,1,50)']).
      group('name', 'table_size').order(:table_size).to_sql

    @db_response = ActiveRecord::Base.connection.select(@sql)

    @visualize_chart_bar = SqlRequest.select(['name', 'table_size', 'avg(sql_duration) AS avg', 'GROUP_CONCAT(sql_duration)']).
      group('name', 'table_size').order(:table_size).group_by(&:table_size)

    @visualize_chart_area = SqlRequest.select(['name', 'scenario', 'table_size', 'avg(sql_duration) AS avg', 'GROUP_CONCAT(sql_duration)']).
      group('name', 'scenario', 'table_size').order(:scenario, :table_size).group_by(&:scenario)
  end

end
