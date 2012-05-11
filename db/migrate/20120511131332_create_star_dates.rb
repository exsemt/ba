class CreateStarDates < ActiveRecord::Migration
  def change
    create_table :star_dates do |t|
      t.integer :day
      t.integer :month
      t.integer :quarter
      t.integer :year
    end
  end
end
