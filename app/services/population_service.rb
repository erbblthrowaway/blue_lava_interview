class PopulationService
  def self.get_population(year)
    year = year.to_i

    return 0 if year < Population.min_year
    return 0 if year > 2500

    target_year = Date.new(year)

    pop = Population.get_max_less_than_year(target_year)

    # If we can't find a minimum value, return nil
    return nil unless pop

    # If there's an exact match, return it
    return pop.population if pop.year == target_year

    next_pop = Population.get_min_greater_than_year(target_year)

    # If we're between two known years, return that.
    return PopulationCalculator.estimated_pop_for_past_year(pop, next_pop, year).population if next_pop

    # If we don't have a greater value, estimate it out based on an exponential model
    return PopulationCalculator.estimated_future_pop(pop, year).population
  end

  def self.request_population(year)
    pop_value = get_population year
    logged_value = RequestLog.create! query: year, response: pop_value
    logged_value.save

    pop_value
  end
end