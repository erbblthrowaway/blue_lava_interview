class PopulationService
  def self.get_population(year, use_exponential = true)
    year = year.to_i

    return {population: 0, exact: false} if year < Population.min_year || year > 2500

    target_year = Date.new(year)

    pop = Population.get_max_less_than_year(target_year)

    # If we can't find a minimum value, return nil
    return nil unless pop

    # If there's an exact match, return it
    return {population: pop.population, exact: true} if pop.year == target_year

    next_pop = Population.get_min_greater_than_year(target_year)

    # If we're between two known years, return that.
    return {population: PopulationCalculator.estimated_pop_for_past_year(pop, next_pop, year).population, exact: false} if next_pop

    if use_exponential
      calculated_pop = PopulationCalculator.future_pop_exponential(pop, year).population
    else
      calculated_pop = PopulationCalculator.future_pop_logistic(pop, year).population
    end
    # If we don't have a greater value, estimate it out based on an exponential model
    return {population: calculated_pop, exact: false}
  end

  def self.request_population(year, use_exponential = true)
    year = year.to_i
    pop_value = get_population year, use_exponential
    logged_value = RequestLog.create!({query: Date.new(year), response: pop_value[:population], exact: pop_value[:exact]})
    logged_value.save

    pop_value[:population]
  end
end
