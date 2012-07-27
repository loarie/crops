class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.integer :average_predicted_yield
      t.integer :uncertaincy
      t.datetime :start_sowing_date
      t.datetime :optimal_sowing_date
      t.datetime :end_sowing_date
      t.datetime :start_harvest_date
      t.datetime :optimal_harvest_date
      t.datetime :end_harvest_date
    end
    
  end

  def self.down
    drop_table :responses
  end
end
