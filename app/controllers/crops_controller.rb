class CropsController < ApplicationController
  layout nil
  layout 'application', :except => :index
  def index
    lat = ""
    lon = ""
    @warning = false
    if params[:crop]
      crop = params[:crop]
    else
      @string = "Please enter a crop"
      @warning = true
      return
    end
    if params[:lat]
      lat = params[:lat]
    else
      @string = "Please enter a latitude"
      @warning = true
      return
    end
    if params[:lon]
      lon = params[:lon]
    else
      @string = "Please enter a longitude"
      @warning = true
      render :layout => false
    end
    if params[:stat]
      stat = params[:stat]
    else
      @string = "Please enter a statistic"
      @warning = true
      return
    end
    crops = ["maize","soy","cassava"]
    unless crops.include? crop
      @string = "We have no projections for the crop #{crop}"
      @warning = true
      return
    end
    unless /^[\d]+(\.[\d]+){0,1}$/ === lat && /^[\d]+(\.[\d]+){0,1}$/ === lon
      @string = "We could not match your location, Lat: #{lat} Lon: #{lon}"
      @warning = true
      return
    end
    stats = ["planting","harvest","yield"]
    unless stats.include? stat
      @string = "We have no projections for #{stat}"
      @warning = true
      return
    end    
    @string = "You requested #{stat} projections for #{crop} from Lat: #{lat} Lon: #{lon}"
  end
end