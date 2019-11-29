module ApplicationHelper

  def year
    if @year
      @year.html_safe
    end
  end

  def population
    @population
  end

end
