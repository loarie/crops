class CodesController < ApplicationController
  layout nil
  layout 'application', :except => :index
  def index
    crop_codes = {
      1 => "Bean / Cowpea",
      2 => "CABBAGE",
      3 => "CARROT",
      4 => "CASSAVA",
      5 => "MAIZE",
      6 => "SWEET POATO",
      7 => "EGGPLANT",
      8 => "FONIO",
      9 => "MILLET",
      10 => "OKRA",
      11 => "ONION",
      12 => "PEANUT",
      13 => "POTATO",
      14 => "RICE",
      15 => "SESAME",
      16 => "SORGHUM",
      17 => "SQUASH",
      18 => "TOMATO",
      19 => "WATERMELON",
      20 => "GREEN BEAN",
      21 => "BANANAS",
      22 => "PEPPER"
    }
    unless params[:crop_id] && params[:lon] && params[:lat]
      return
    end
    crop_name = crop_codes[params[:crop_id].to_i]
    lon = params[:lon]
    lat = params[:lat]
    num = 0.08333
    @crop = Code.first(:conditions => ["crop_name = ? AND (lat - #{num}) < ? AND (lat + #{num}) > ? AND (lon - #{num}) < ? AND (lon + #{num}) > ?", crop_name, lat, lat, lon, lon])
    @altresponse = Code.first(:conditions => ["(lat - #{num}) < ? AND (lat + #{num}) > ? AND (lon - #{num}) < ? AND (lon + #{num}) > ?", lat, lat, lon, lon])
    
    unless @altresponse
      render :json => {:alert => "No data for that location"}
      return
    end
    
    if @crop
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
        :crop => @crop.crop_name.downcase,
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
    else
      render :json => {:alert => "No data for this crop at that location"}
    end
  end
end