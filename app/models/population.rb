class Population < ApplicationRecord

  def self.min_year
    Population.all.map(&:year).min.year
  end

  def self.get_max_less_than_year(year)
    Population.where("year <= :year", year: year).order('year desc').first
  end

  def self.get_min_greater_than_year(year)
    Population.where("year >= :year", year: year).order('year asc').first
  end

  def self.most_popular_years
    Population.connection.select_all "SELECT populations.year, COUNT(request_logs.id) AS query_count FROM populations LEFT JOIN request_logs ON request_logs.query = populations.year GROUP BY populations.year ORDER BY query_count desc"
  end
end
