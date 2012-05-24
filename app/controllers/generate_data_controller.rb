class GenerateDataController < ApplicationController
  require 'populator'
  require 'faker'

  def index
  end

  def destroy
    clear_tables

    redirect_to generate_data_path
  end

  ######################### Star Schema #####################################
  def generate_star_data
    # attr_accessible :brand, :category, :contents, :name, :price, :product_no
    Star::Product.populate params[:generate][:product].to_i do |product|
      product.brand = ['Punica', 'Coca-Cola', 'Rauch', 'Red Bull', 'Flensburger Brauerei', 'Holsten-Brauerei', 'Warsteiner Brauerei', "Beck's", 'Duckstein (Bier)']
      product.category = ['alkohol', 'alkoholfrei']
      product.contents = [0.33, 0.5, 1.0, 1.25, 1.5]
      product.name = ['Punica Classics Rote Fruechte', 'Punica Melontropic', 'Punica Multivitamin',
                      'Coca-Cola light koffeinfrei', 'Coca-Cola Zero',
                      'Rauch Ice Tea Peach', 'Rauch Green Tea', 'Rauch Ice Tea Strawberry Kiwi',
                      'Red Bull', 'Red Bull Cola',
                      'Flensburger Pilsener', 'Flensburger Gold', 'Flensburger Dunkel',
                      'Holsten Pilsener', 'Holsten Lemon',
                      'Warsteiner Lemon', 'Warsteiner Pilsener',
                      "Beck's", "Beck's Lemon",
                      'Duckstein', 'Duckstein Dunkel']
      product.price = [0.40, 0.50, 1.30, 1.50, 2.0, 0.6, 2.50]
      product.product_no = 1..1000
    end

    # attr_accessible :city, :country, :customer_no, :name, :postcode, :street_number, :customer_type
    Star::Customer.populate params[:generate][:customer].to_i do |customer|
      customer.city = Faker::Address.city
      customer.country = ['Deutschland']#Faker::Address.country
      customer.customer_no = 1..1000
      customer.name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
      customer.postcode = Faker::Address.postcode
      customer.street_number = Faker::Address.street_name
      customer.customer_type = ['privat', 'gewerblich']
    end

    # attr_accessible :day, :month, :quarter, :year
    Star::Date.populate params[:generate][:date].to_i do |date|
      date.day = 1..30
      date.month = 1..12
      date.quarter = 1..4
      date.year = [2009, 2010, 2011]
    end

    # attr_accessible :branch_no, :city, :postcode, :state, :street_number
    Star::Branch.populate params[:generate][:branch].to_i do |date|
      date.branch_no = 1..100
      date.city = Faker::Address.city
      date.postcode = Faker::Address.postcode
      date.state = ['Baden-Wuerttemberg','Bayern','Berlin','Brandenburg','Bremen','Hamburg','Hessen','Mecklenburg-Vorpommern',
        'Niedersachsen','Nordrhein-Westfalen','Rheinland-Pfalz','Saarland','Sachsen','Sachsen-Anhalt','Schleswig-Holstein','Thueringen']
      date.street_number = Faker::Address.street_name
    end

    product_ids = Star::Product.select(:id).map(&:id)
    customer_ids = Star::Customer.select(:id).map(&:id)
    date_ids = Star::Date.select(:id).map(&:id)
    branch_ids = Star::Branch.select(:id).map(&:id)

    Star::Fact.populate params[:generate][:fact].to_i do |fact|
      fact.product_id = product_ids
      fact.customer_id = customer_ids
      fact.date_id = date_ids
      fact.branch_id = branch_ids
      fact.number = 1..20
      fact.discount = 1..10
      fact.commission = [0, 0, 0, 10, 20]
    end

    redirect_to generate_data_path
  end

  ########################### Generic Model ##############################
  def copy_attrs_from_star
    copy_star_attrs

    redirect_to generate_data_path
  end

  def copy_dimension_data_from_star
    dimensions = GenericTable::Dimension.select('distinct(generic_table_dimensions.name), generic_table_dimensions.*').
      joins(:aggregations).where('generic_table_dimensions.name != generic_table_aggregations.name')

   dimensions.each do |dimension|
     Star::Fact.first.send(dimension.name.downcase).class.all.each do |star_dim|
       Generic::Dimension.new(star_dim.attributes.merge(:dimension_name => dimension.name)).create!
     end
   end

    redirect_to generate_data_path
  end

  def copy_fact_data_from_star
    copy_star_data

    redirect_to generate_data_path
  end

  def copy_star_completely
    params[:id] = 'generic'
    clear_tables

    # copy attributes from star-schema
    copy_star_attrs

    # copy fact data form star
    copy_star_data

    redirect_to generate_data_path
  end

private

  def copy_star_attrs
    # import product {:brand, :category, :contents, :name, :price, :product_no}
    product_id =    GenericTable::Dimension.create!(  :name => 'Product').id
    contents_id =   GenericTable::Aggregation.create!(:name => 'contents',                             :dimension_id => product_id).id
    brand_id =      GenericTable::Aggregation.create!(:name => 'brand',    :parent_id => contents_id,  :dimension_id => product_id).id
    category_id =   GenericTable::Aggregation.create!(:name => 'category', :parent_id => brand_id,     :dimension_id => product_id).id
    name_id =       GenericTable::Aggregation.create!(:name => 'name',     :parent_id => category_id,  :dimension_id => product_id).id
    product_no_id = GenericTable::Aggregation.create!(:name => 'product_no',:parent_id => name_id,     :dimension_id => product_id).id
    GenericTable::Aggregation.create!(                :name => 'price',    :parent_id => product_no_id,:dimension_id => product_id)

    # import customer {:city, :country, :customer_no, :name, :postcode, :street_number, :customer_type}
    customer_id =      GenericTable::Dimension.create!(:name => 'Customer').id
    country_id =       GenericTable::Aggregation.create!(:name => 'country', :dimension_id => customer_id).id
    city_id =          GenericTable::Aggregation.create!(:name => 'city', :parent_id => country_id, :dimension_id => customer_id).id
    postcode_id =      GenericTable::Aggregation.create!(:name => 'postcode', :parent_id => city_id, :dimension_id => customer_id).id
    street_number_id = GenericTable::Aggregation.create!(:name => 'street_number', :parent_id => postcode_id, :dimension_id => customer_id).id
    customer_type_id = GenericTable::Aggregation.create!(:name => 'customer_type', :parent_id => street_number_id, :dimension_id => customer_id).id
    GenericTable::Aggregation.create!(:name => 'name', :parent_id => customer_type_id, :dimension_id => customer_id)

    # import branch {:branch_no, :city, :postcode, :state, :street_number}
    branch_id =   GenericTable::Dimension.create!(:name => 'Branch').id
    state_id =    GenericTable::Aggregation.create!(:name => 'state', :dimension_id => branch_id).id
    city_id =     GenericTable::Aggregation.create!(:name => 'city', :parent_id => state_id, :dimension_id => customer_id).id
    postcode_id = GenericTable::Aggregation.create!(:name => 'postcode', :parent_id => city_id, :dimension_id => customer_id).id
    street_number_id = GenericTable::Aggregation.create!(:name => 'street_number', :parent_id => postcode_id, :dimension_id => customer_id).id
    GenericTable::Aggregation.create!(:name => 'branch_no', :parent_id => street_number_id, :dimension_id => customer_id)

    # import date
    date_id =    GenericTable::Dimension.create!(:name => 'Date').id
    year_id =    GenericTable::Aggregation.create!(:name => 'year', :dimension_id => date_id).id
    quarter_id = GenericTable::Aggregation.create!(:name => 'quarter', :parent_id => year_id, :dimension_id => date_id).id
    month_id =   GenericTable::Aggregation.create!(:name => 'month', :parent_id => quarter_id, :dimension_id => date_id).id
    GenericTable::Aggregation.create!(:name => 'day', :parent_id => month_id, :dimension_id => date_id)

    # import value
    value_id = GenericTable::Dimension.create!(:name => 'value').id
    aggr_value_id = GenericTable::Aggregation.create!(:name => 'value', :dimension_id => value_id).id
    GenericTable::DimensionValue.create!(:aggregation_id => aggr_value_id, :value => 'number')
    GenericTable::DimensionValue.create!(:aggregation_id => aggr_value_id, :value => 'discount')
    GenericTable::DimensionValue.create!(:aggregation_id => aggr_value_id, :value => 'commission')
  end

  def copy_star_data
    dimension_names = GenericTable::Dimension.all.map(&:name)

    Star::Fact.all.each do |fact|
      attrs = []
      fact_attrs = fact.attributes
      fact_attrs.delete('id')

      fact_attrs.each do |header, value|
        attrs << if dimension_names.any?{|name| name.downcase == header.sub('_id','') }
          star_dimension = fact.send(header.sub('_id','')).attributes
          star_dimension.delete('id')

          dimension_id = Generic::Dimension.new(star_dimension.merge(:dimension_name => header.sub('_id','').capitalize)).create!

          {:dimension_value_id => dimension_id[:last_id], :header => header}
        else
          {:fact_value => value.to_s, :header => header}
        end
      end

      Generic::Fact.create!(attrs)
    end
  end

  def clear_tables
    tables = if params[:id] == 'star'
      [Star::Fact, Star::Product, Star::Customer, Star::Date]
    elsif params[:id] == 'generic'
      [GenericTable::Aggregation, GenericTable::Dimension,
        GenericTable::DimensionValue, GenericTable::FactValue]
    else
      []
    end

    tables.each(&:delete_all)

    tables.each do |table|
      ActiveRecord::Base.connection.execute("ALTER TABLE %s AUTO_INCREMENT = %d" % [table.table_name, 1])
    end
  end
end
