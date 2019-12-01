class PopulationsController < ApplicationController
  def index
    if params[:year]
      @year = params[:year].html_safe
      @population = PopulationService.request_population(@year)
    end
  end
end
