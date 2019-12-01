class TheLogzController < ApplicationController
  def index
    response.set_header("REFRESH", 10)
    @log_entries = RequestLog.all_logs
    @most_popular = Population.most_popular_years
  end
end
