class CodesController < ApplicationController
  layout nil
  layout 'application', :except => :index
  def index
    crop_codes = {
      1 => "Cowpea",
      2 => "Cabbage",
      3 => "Carrotv",
      4 => "Cassava",
      5 => "Maize",
      6 => "Maize",
      7 => "Eggplant",
      8 => "Fonio",
      9 => "Millet",
      10 => "Okra",
      11 => "Onion",
      12 => "Groundnut",
      13 => "Potato",
      14 => "Rice",
      15 => "Sesame",
      16 => "Sorghum",
      17 => "Squash",
      18 => "Tomato",
      19 => "Watermelon"
    }
    unless params[:crop_id] && params[:lon] && params[:lat]
      return
    end
    crop_name = crop_codes[params[:crop_id]]
    lon = params[:lon]
    lat = params[:lat]
    @crop = Code.first
    
    crop_optimal_harvest_date = @crop.optimal_harvest_date
    crop_start_harvest_date = @crop.start_harvest_date
    crop_end_harvest_date = @crop.end_harvest_date
    
    crop_optimal_sowing_date = @crop.optimal_sowing_date
    crop_start_sowing_date = @crop.start_sowing_date
    crop_end_sowing_date = @crop.end_sowing_date
    
    if sowing_date = params[:sowing_date]
      sowing_date = sowing_date.split("-")
      optimal_sowing_date = DateTime.new( sowing_date[0].to_i, sowing_date[1].to_i, sowing_date[2].to_i )
      start_sowing_date = ( ( crop_start_sowing_date - crop_optimal_sowing_date ) / 60 ).minutes.since optimal_sowing_date
      end_sowing_date = ( ( crop_end_sowing_date - crop_optimal_sowing_date ) / 60 ).minutes.since optimal_sowing_date
      
      crop_start_harvest_date = ( ( crop_start_harvest_date - crop_start_sowing_date ) / 60 ).minutes.since start_sowing_date
      crop_optimal_harvest_date = ( ( crop_optimal_harvest_date - crop_optimal_sowing_date ) / 60 ).minutes.since optimal_sowing_date
      crop_end_harvest_date = ( ( crop_end_harvest_date - crop_end_sowing_date ) / 60 ).minutes.since end_sowing_date
      
      crop_optimal_sowing_date = optimal_sowing_date
      crop_start_sowing_date = start_sowing_date
      crop_end_sowing_date = end_sowing_date
    end
    @response = Response.new(
      :average_predicted_yield => @crop.average_predicted_yield,
      :uncertaincy => @crop.uncertaincy,
      :start_sowing_date => crop_start_sowing_date,
      :optimal_sowing_date => crop_optimal_sowing_date,
      :end_sowing_date => crop_end_sowing_date,
      :start_harvest_date => crop_start_harvest_date,
      :optimal_harvest_date => crop_optimal_harvest_date,
      :end_harvest_date => crop_end_harvest_date
    )
    render :json => @response
  end
end