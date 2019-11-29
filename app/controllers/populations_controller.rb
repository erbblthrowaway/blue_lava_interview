class PopulationsController < ApplicationController
  def index
    if params[:year]
      @year = params[:year].html_safe
      @population = Population.get(@year)
    end
  end
end
