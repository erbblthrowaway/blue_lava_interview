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

  def self.get(year)
    year = year.to_i

    return 0 if year < min_year
    return 0 if year > 2500

    target_year = Date.new(year)

    pop = Population.get_max_less_than_year(target_year)

    # If we can't find a minimum value, return nil
    return nil unless pop

    # If there's an exact match, return it
    return pop.population if pop.year == target_year

    next_pop = get_min_greater_than_year(target_year)

    # If we're between two known years, return that.
    return PopulationCalculator.estimated_pop_for_past_year(pop, next_pop, year).population if next_pop

    # If we don't have a greater value, estimate it out based on an exponential model
    return PopulationCalculator.estimated_future_pop(pop, year).population
  end

end
