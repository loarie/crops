require 'time'
filename = "tools/big_crops.csv"
FasterCSV.foreach(filename, :col_sep =>',', :headers => :first_row) do |row|
  season = row["season"]
  unless season == "NA"
    lat = row["lon"] #whoops these are backwards
    lon = row["lat"] #
    crop = row["crop"]
    average_predicted_yield = row["average_predicted_yield"]
    uncertainty = row["uncertainty"]
    start_sowing_date_raw = row["start_sowing_date"]
    end_sowing_date_raw = row["end_sowing_date"]
    start_harvest_date_raw = row["start_harvest_date"]
    end_harvest_date_raw = row["end_harvest_date"]
    
    start_sowing_date_mid = start_sowing_date_raw.split("/")
    start_sowing_date = DateTime.new( 2012,start_sowing_date_mid[1].to_i, start_sowing_date_mid[0].to_i)
    end_sowing_date_mid = end_sowing_date_raw.split("/")
    end_sowing_date = DateTime.new( 2012,end_sowing_date_mid[1].to_i, end_sowing_date_mid[0].to_i )
    unless end_sowing_date > start_sowing_date
      end_sowing_date = DateTime.new( 2013,end_sowing_date_mid[1].to_i, end_sowing_date_mid[0].to_i )
    end
    start_sowing_date_time = Time.parse(start_sowing_date.to_s)
    end_sowing_date_time = Time.parse(end_sowing_date.to_s)
    avg = Time.at((start_sowing_date_time.to_f + end_sowing_date_time.to_f) / 2)
    optimal_sowing_date = Date.parse(avg.to_s)
    
    season = season.split(" days")[0].split("-")
    midseason = ( season[1].to_i - season[0].to_i ) + season[0].to_i
    start_harvest_date_calc = start_sowing_date.to_time.advance( :days => season[1].to_i )
    end_harvest_date_calc = end_sowing_date.to_time.advance( :days => season[0].to_i )
    optimal_harvest_date_calc = optimal_sowing_date.to_time.advance( :days => midseason )
    
    code = Code.new(
      :crop_name => crop,
      :lat => lat.to_f,
      :lon => lon.to_f,
      :average_predicted_yield => average_predicted_yield.to_f*100.to_i,
      :uncertaincy => uncertainty.to_i,
      :start_sowing_date => start_sowing_date,
      :optimal_sowing_date => optimal_sowing_date,
      :end_sowing_date => end_sowing_date,
      :start_harvest_date => start_harvest_date_calc,
      :optimal_harvest_date => optimal_harvest_date_calc,
      :end_harvest_date => end_harvest_date_calc
    )
    code.save
  end
end
