class ComparisonsController < ApplicationController

  def index
    if ['star_schema', 'generic_model'].include?(params['model']) && !params['commit'].blank?
      case params['commit']
        when 'scenario_1'
          redirect_to scenario_1_comparisons_path(:model => params['model'])
        when 'scenario_2'
          redirect_to scenario_2_comparisons_path(:model => params['model'])
        when 'scenario_3'
          redirect_to scenario_3_comparisons_path(:model => params['model'])
        else
          flash[:error] = "ERROR: unknown scenario!"
      end
    end
  end

  def scenario_1
    if params['model'] == 'star_schema'
      # "SELECT state, sum(star_facts.number * star_products.price) AS turnover FROM `star_branches`
      #   INNER JOIN `star_facts` ON `star_facts`.`branch_id` = `star_branches`.`id`
      #   INNER JOIN `star_dates` ON `star_dates`.`id` = `star_facts`.`date_id`
      #   INNER JOIN `star_products` ON `star_products`.`id` = `star_facts`.`product_id`
      #   WHERE (star_dates.year = 2010) GROUP BY state ORDER BY turnover DESC"
      @sql = Star::Branch.select([:state, 'sum(star_facts.number * star_products.price) AS turnover']).
        joins(:facts => [:date, :product]).where('star_dates.year = 2010').order('turnover DESC').group(:state).to_sql
    else
      # example: select sum(value) from generic_fact_value_tables where dimension_value_table_id = (select id from generic_dimension_value_tables where value = 'number')
      # ActiveRecord::Base.connection.select(Generic::FactValueTable.select(["generic_dimension_value_tables.value AS city", "sum(generic_dimension_value_tables.value) AS turnover"]).joins(:dimension_value_table => :aggregation_table).where('generic_aggregation_tables.name = "price"').to_sql)


    end

    @states = ActiveRecord::Base.connection.select(@sql)
  end

  def scenario_2
    if params['model'] == 'star_schema'
      # "SELECT star_products.*, sum(star_facts.number) AS number FROM `star_products`
      #   INNER JOIN `star_facts` ON `star_facts`.`product_id` = `star_products`.`id`
      #   INNER JOIN `star_branches` ON `star_branches`.`id` = `star_facts`.`branch_id`
      #   INNER JOIN `star_customers` ON `star_customers`.`id` = `star_facts`.`customer_id`
      #   WHERE (star_branches.state = "Hamburg") AND (star_customers.customer_type = "privat")
      #   GROUP BY star_products.id
      #   LIMIT 20"
      @sql = Star::Product.select(['star_products.*', 'sum(star_facts.number) AS number']).
        joins(:facts => [:branch, :customer]).
        where('star_branches.state = "Hamburg"').
        where('star_customers.customer_type = "privat"').
        group('star_products.id').limit(20).to_sql
    else

    end

    @products = ActiveRecord::Base.connection.select(@sql)
  end

  def scenario_3
    if params['model'] == 'star_schema'
      # "SELECT star_products.* FROM `star_products`
      #   INNER JOIN `star_facts` ON `star_facts`.`product_id` = `star_products`.`id`
      #   INNER JOIN `star_dates` ON `star_dates`.`id` = `star_facts`.`date_id`
      #   WHERE (star_dates.month = 12 AND star_dates.year = 2010)"
      @sql = Star::Product.select('star_products.*').joins(:facts => :date).
        where('star_dates.month = 12 AND star_dates.year = 2010').to_sql
    else

    end

    @states = ActiveRecord::Base.connection.select(@sql)
  end

end
