# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120526110708) do

  create_table "generic_table_aggregations", :force => true do |t|
    t.string  "name"
    t.integer "dimension_id"
    t.integer "parent_id"
  end

  create_table "generic_table_dimension_values", :force => true do |t|
    t.integer "aggregation_id"
    t.integer "parent_id"
    t.string  "value"
  end

  create_table "generic_table_dimensions", :force => true do |t|
    t.string "name"
  end

  create_table "generic_table_fact_values", :force => true do |t|
    t.integer "group"
    t.integer "dimension_value_id"
    t.string  "value"
  end

  create_table "sql_requests", :force => true do |t|
    t.string   "server_id"
    t.datetime "start"
    t.datetime "finish"
    t.float    "sql_duration"
    t.string   "name"
    t.text     "sql_query"
    t.text     "payload"
    t.integer  "table_size"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "star_branches", :force => true do |t|
    t.integer "branch_no"
    t.string  "state"
    t.string  "city"
    t.string  "postcode"
    t.string  "street_number"
  end

  create_table "star_customers", :force => true do |t|
    t.integer "customer_no"
    t.string  "name"
    t.string  "customer_type"
    t.string  "street_number"
    t.string  "city"
    t.string  "postcode"
    t.string  "country"
  end

  create_table "star_dates", :force => true do |t|
    t.integer "day"
    t.integer "month"
    t.integer "quarter"
    t.integer "year"
  end

  create_table "star_facts", :force => true do |t|
    t.integer "customer_id"
    t.integer "product_id"
    t.integer "branch_id"
    t.integer "date_id"
    t.integer "number"
    t.float   "discount"
    t.float   "commission"
  end

  create_table "star_products", :force => true do |t|
    t.integer "product_no"
    t.string  "name"
    t.string  "category"
    t.string  "brand"
    t.string  "contents"
    t.float   "price"
  end

end
