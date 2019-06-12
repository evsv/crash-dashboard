require 'sodadataloader'

class DashboardController < ApplicationController
  def dataload
  end

  def visualisations
  end

  def load_socrata_data
    date_given = DateTime.parse(params[:dt]).to_date 
    window = params[:wndw].to_i
    start_date = (date_given - window)
    end_date = (date_given + window)
    loader = SodaLoader.new
    loader.load_db(start_date, end_date)

    redirect_back(fallback_location: root_path)
  end 
end
