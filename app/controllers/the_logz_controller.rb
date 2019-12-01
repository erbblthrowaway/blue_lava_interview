class TheLogzController < ApplicationController
  def index
    @log_entries = RequestLog.all_logs
    @most_popular = Population.most_popular_years
  end
end
