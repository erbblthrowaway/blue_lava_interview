class TheLogzController < ApplicationController
  def index
    @log_entries = RequestLog.all_logs
  end
end
