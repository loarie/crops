code = Code.new(
  :crop_name => "peanut",
  :cell_id => 1,
  :average_predicted_yield => 633,
  :uncertaincy => 20,
  :start_sowing_date => DateTime.new(2012,6,15),
  :optimal_sowing_date => DateTime.new(2012,7,1),
  :end_sowing_date => DateTime.new(2012,7,31),
  :start_harvest_date => DateTime.new(2012,9,10),
  :optimal_harvest_date => DateTime.new(2012,10,1),
  :end_harvest_date => DateTime.new(2012,10,15)
)
code.save