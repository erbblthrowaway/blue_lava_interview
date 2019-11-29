class Population < ApplicationRecord

  def self.min_year
    Population.all.map(&:year).min.year
  end

  def self.get_max_less_than_year(year)
    Population.where("year <= :year", year: year).order('year desc').first
  end

  def self.get(year)
    year = year.to_i

    return 0 if year < min_year

    pop = Population.get_max_less_than_year(Date.new(year))

    return pop.population if pop

    nil
  end

end
