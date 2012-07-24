class CropsController < ApplicationController
  
  def index
    lat = ""
    lon = ""
    if params[:crop]
      crop = params[:crop]
    else
      @string = "Please enter a crop"
      return
    end
    if params[:lat]
      lat = params[:lat]
    else
      @string = "Please enter a latitude"
      return
    end
    if params[:lon]
      lon = params[:lon]
    else
      @string = "Please enter a longitude"
      return
    end
    if params[:stat]
      stat = params[:stat]
    else
      @string = "Please enter a statistic"
      return
    end
    crops = ["maize","soy","cassava"]
    unless crops.include? crop
      @string = "We have no projections for the crop #{crop}"
      return
    end
    unless /^[\d]+(\.[\d]+){0,1}$/ === lat && /^[\d]+(\.[\d]+){0,1}$/ === lon
      @string = "We could not match your location, Lat: #{lat} Lon: #{lon}"
      return
    end
    stats = ["planting","harvest","yield"]
    unless stats.include? stat
      @string = "We have no projections for #{stat}"
      return
    end    
    @string = "You requested #{stat} projections for #{crop} from Lat: #{lat} Lon: #{lon}"
  end
end