class ComparisonsController < ApplicationController

  def index
    SUBSCRIBE['SQL'] = true

    if ['star_schema', 'generic_model'].include?(params['model']) && !params['commit'].blank?
      case params['commit']
        when 'case_1'
          @sql = case_1(params['model'])
        when 'case_2'
          @sql = case_2(params['model'])
        when 'case_3'
          @sql = case_3(params['model'])
        else
          flash[:error] = "ERROR: unknown scenario case!"
      end

      @db_response = ActiveRecord::Base.connection.select(@sql, :model => "#{params['model']}_#{params['commit']}", :scenario_case => params['commit']) unless @sql.blank?
    end

    SUBSCRIBE['SQL'] = false
  end

private

  def case_1(model)
    if model == 'star_schema'
      # "SELECT state, sum(star_facts.number * star_products.price) AS turnover FROM `star_branches`
      #   INNER JOIN `star_facts` ON `star_facts`.`branch_id` = `star_branches`.`id`
      #   INNER JOIN `star_dates` ON `star_dates`.`id` = `star_facts`.`date_id`
      #   INNER JOIN `star_products` ON `star_products`.`id` = `star_facts`.`product_id`
      #   WHERE (star_dates.year = 2010) GROUP BY state ORDER BY turnover DESC"
      Star::Branch.select([:state, 'sum(star_facts.number * star_products.price) AS turnover']).
        joins(:facts => [:date, :product]).where('star_dates.year = 2010').order('turnover DESC').group(:state).to_sql
    else
      "SELECT
        (SELECT dv_5.value
          FROM generic_table_fact_values
            INNER JOIN generic_table_dimension_values dv_1 ON dv_1.id = generic_table_fact_values.dimension_value_id
            INNER JOIN  generic_table_aggregations ON generic_table_aggregations.id = dv_1.aggregation_id
            INNER JOIN generic_table_dimensions ON generic_table_dimensions.id = generic_table_aggregations.dimension_id,
            generic_table_dimension_values dv_2, generic_table_dimension_values dv_3,
            generic_table_dimension_values dv_4, generic_table_dimension_values dv_5
          WHERE dv_1.parent_id = dv_2.id
            AND dv_2.parent_id = dv_3.id
            AND dv_3.parent_id = dv_4.id
            AND dv_4.parent_id = dv_5.id
            AND generic_table_dimensions.name = 'Branch'
            AND generic_table_fact_values.group = FACT.f_group) AS state,
        sum(FACT.f_value * (SELECT generic_table_dimension_values.value AS d_value
          FROM generic_table_fact_values
            INNER JOIN generic_table_dimension_values
              ON generic_table_dimension_values.id = generic_table_fact_values.dimension_value_id
            INNER JOIN generic_table_aggregations ON generic_table_aggregations.id = generic_table_dimension_values.aggregation_id
            INNER JOIN generic_table_dimensions ON generic_table_dimensions.id = generic_table_aggregations.dimension_id
          WHERE generic_table_dimensions.name = 'Product'
            AND generic_table_fact_values.group = FACT.f_group AND generic_table_aggregations.name = 'price')) AS turnover
      FROM (SELECT generic_table_dimension_values.value AS d_value,
          generic_table_fact_values.group AS f_group, generic_table_fact_values.value AS f_value
        FROM generic_table_fact_values
          INNER JOIN generic_table_dimension_values
            ON generic_table_dimension_values.id = generic_table_fact_values.dimension_value_id) FACT
      where FACT.d_value = 'number'
        AND (SELECT dv_4.value
          FROM generic_table_fact_values
            INNER JOIN generic_table_dimension_values dv_1 ON dv_1.id = generic_table_fact_values.dimension_value_id
            INNER JOIN  generic_table_aggregations ON generic_table_aggregations.id = dv_1.aggregation_id
            INNER JOIN generic_table_dimensions ON generic_table_dimensions.id = generic_table_aggregations.dimension_id,
            generic_table_dimension_values dv_2, generic_table_dimension_values dv_3, generic_table_dimension_values dv_4
          WHERE dv_1.parent_id = dv_2.id
            AND dv_2.parent_id = dv_3.id
            AND dv_3.parent_id = dv_4.id
            AND generic_table_dimensions.name = 'Date'
            AND generic_table_fact_values.group = FACT.f_group) = 2010
      GROUP BY state
      ORDER BY turnover DESC"
    end
  end

  def case_2(model)
    if model == 'star_schema'
      # "SELECT star_products.name AS name, sum(star_facts.number) AS number FROM `star_products`
      #   INNER JOIN `star_facts` ON `star_facts`.`product_id` = `star_products`.`id`
      #   INNER JOIN `star_branches` ON `star_branches`.`id` = `star_facts`.`branch_id`
      #   INNER JOIN `star_customers` ON `star_customers`.`id` = `star_facts`.`customer_id`
      #   WHERE (star_branches.state = "Hamburg") AND (star_customers.customer_type = "privat")
      #   GROUP BY name ORDER BY number DESC
      #   LIMIT 20"
      Star::Product.select(['star_products.name AS name', 'sum(star_facts.number) AS number']).joins(:facts => [:branch, :customer]).
        where('star_branches.state = "Hamburg"').where('star_customers.customer_type = "privat"').
        group('name').order('number DESC').limit(20).to_sql
    else
      "SELECT
        (SELECT dv_3.value
          FROM generic_table_fact_values
            INNER JOIN generic_table_dimension_values dv_1 ON dv_1.id = generic_table_fact_values.dimension_value_id
            INNER JOIN  generic_table_aggregations ON generic_table_aggregations.id = dv_1.aggregation_id
            INNER JOIN generic_table_dimensions ON generic_table_dimensions.id = generic_table_aggregations.dimension_id,
            generic_table_dimension_values dv_2, generic_table_dimension_values dv_3, generic_table_dimension_values dv_4,
            generic_table_dimension_values dv_5, generic_table_dimension_values dv_6
          WHERE dv_1.parent_id = dv_2.id
            AND dv_2.parent_id = dv_3.id
            AND dv_3.parent_id = dv_4.id
            AND dv_4.parent_id = dv_5.id
            AND dv_5.parent_id = dv_6.id
            AND generic_table_dimensions.name = 'Product'
            AND generic_table_fact_values.group = FACT.f_group) AS name,
        SUM(FACT.f_value) AS number
      FROM (SELECT generic_table_dimension_values.value AS d_value,
          generic_table_fact_values.group AS f_group,
          generic_table_fact_values.value AS f_value
        FROM generic_table_fact_values
          INNER JOIN generic_table_dimension_values ON
            generic_table_dimension_values.id = generic_table_fact_values.dimension_value_id) FACT
      where FACT.d_value = 'number'
        AND (SELECT dv_5.value
            FROM generic_table_fact_values
            INNER JOIN generic_table_dimension_values dv_1 ON dv_1.id = generic_table_fact_values.dimension_value_id
            INNER JOIN  generic_table_aggregations ON generic_table_aggregations.id = dv_1.aggregation_id
            INNER JOIN generic_table_dimensions ON generic_table_dimensions.id = generic_table_aggregations.dimension_id,
            generic_table_dimension_values dv_2, generic_table_dimension_values dv_3,
            generic_table_dimension_values dv_4, generic_table_dimension_values dv_5
          WHERE dv_1.parent_id = dv_2.id
            AND dv_2.parent_id = dv_3.id
            AND dv_3.parent_id = dv_4.id
            AND dv_4.parent_id = dv_5.id
            AND generic_table_dimensions.name = 'Branch'
            AND generic_table_fact_values.group = FACT.f_group) = 'Hamburg'
        AND (SELECT dv_3.value
          FROM generic_table_fact_values
            INNER JOIN generic_table_dimension_values dv_1 ON dv_1.id = generic_table_fact_values.dimension_value_id
            INNER JOIN  generic_table_aggregations ON generic_table_aggregations.id = dv_1.aggregation_id
            INNER JOIN generic_table_dimensions ON generic_table_dimensions.id = generic_table_aggregations.dimension_id,
            generic_table_dimension_values dv_2, generic_table_dimension_values dv_3
          WHERE dv_1.parent_id = dv_2.id
            AND dv_2.parent_id = dv_3.id
            AND generic_table_dimensions.name = 'Customer'
            AND generic_table_fact_values.group = FACT.f_group) = 'privat'
      GROUP BY name
      ORDER BY number DESC
      LIMIT 20"
    end
  end

  def case_3(model)
    if model == 'star_schema'
      # "SELECT star_products.* FROM `star_products`
      #   INNER JOIN `star_facts` ON `star_facts`.`product_id` = `star_products`.`id`
      #   INNER JOIN `star_dates` ON `star_dates`.`id` = `star_facts`.`date_id`
      #   WHERE (star_dates.month = 12 AND star_dates.year = 2010) GROUP BY product_no"
      Star::Product.select('star_products.*').joins(:facts => :date).
        where('star_dates.month = 12 AND star_dates.year = 2010').group('product_no').to_sql
    else
      "SELECT dv_2.value AS product_no, dv_3.value AS name, dv_4.value AS category,
        dv_5.value AS brand, dv_6.value AS contents, dv_1.value AS price
      FROM generic_table_fact_values
        INNER JOIN generic_table_dimension_values dv_1 ON dv_1.id = generic_table_fact_values.dimension_value_id
        INNER JOIN  generic_table_aggregations ON generic_table_aggregations.id = dv_1.aggregation_id
        INNER JOIN generic_table_dimensions ON generic_table_dimensions.id = generic_table_aggregations.dimension_id,
        generic_table_dimension_values dv_2, generic_table_dimension_values dv_3, generic_table_dimension_values dv_4,
        generic_table_dimension_values dv_5 , generic_table_dimension_values dv_6
      WHERE dv_1.parent_id = dv_2.id
        AND dv_2.parent_id = dv_3.id
        AND dv_3.parent_id = dv_4.id
        AND dv_4.parent_id = dv_5.id
        AND dv_5.parent_id = dv_6.id
        AND generic_table_dimensions.name = 'Product'
        AND generic_table_fact_values.group in (SELECT generic_table_fact_values.group
          FROM generic_table_fact_values
            INNER JOIN generic_table_dimension_values dv_1 ON dv_1.id = generic_table_fact_values.dimension_value_id
            INNER JOIN  generic_table_aggregations ON generic_table_aggregations.id = dv_1.aggregation_id
            INNER JOIN generic_table_dimensions ON generic_table_dimensions.id = generic_table_aggregations.dimension_id,
            generic_table_dimension_values dv_2, generic_table_dimension_values dv_3, generic_table_dimension_values dv_4
          WHERE dv_1.parent_id = dv_2.id
            AND dv_2.parent_id = dv_3.id
            AND dv_3.parent_id = dv_4.id
            AND generic_table_dimensions.name = 'Date'
            AND dv_4.value = 2010
            AND dv_2.value = 12)
      GROUP BY product_no"
    end
  end

end
