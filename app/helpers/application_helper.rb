module ApplicationHelper

  def year
    if @year
      @year.html_safe
    end
  end

  def population
    @population
  end

  def log_entries
    @log_entries
  end

end
