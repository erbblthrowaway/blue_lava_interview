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
end
