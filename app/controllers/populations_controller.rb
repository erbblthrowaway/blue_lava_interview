class PopulationsController < ApplicationController
  def index
    if params[:year]
      @year = params[:year].html_safe
      growth_type = params[:growth_type]
      @population = PopulationService.request_population(@year, growth_type == 'exponential')
    end
  end
end
