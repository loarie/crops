class CreateCodes < ActiveRecord::Migration
  def self.up
    create_table :codes do |t|
      t.string :crop_name
      t.float :lat
      t.float :lon
      t.integer :average_predicted_yield
      t.integer :uncertaincy
      t.date :start_sowing_date
      t.date :optimal_sowing_date
      t.date :end_sowing_date
      t.date :start_harvest_date
      t.date :optimal_harvest_date
      t.date :end_harvest_date
      
      t.timestamps
    end
    
  end

  def self.down
    drop_table :codes
  end
end
