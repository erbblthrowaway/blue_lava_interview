class PopulationCalculator
  cattr_reader :carrying_capacity

  @estimated_future_growth_rate = 0.09
  @@carrying_capacity = 750000000

  def self.get_year_difference(min_year, max_year)
    min_year = min_year.to_i
    max_year = max_year.to_i

    max_year - min_year
  end

  def self.get_pop_difference(pop_min, pop_max)
    pop_min = pop_min.to_i
    pop_max = pop_max.to_i

    pop_max - pop_min
  end

  def self.get_pop_delta(pop_difference, year_count)
    pop_difference = pop_difference.to_i
    year_count = year_count.to_i

    (pop_difference / year_count).to_f
  end

  def self.multiply_pops_by_year(pop_delta, year_count)
    pop_delta = pop_delta.to_f
    year_count = year_count.to_i

    (pop_delta * year_count).to_i
  end

  def self.estimated_pop_for_past_year(pop_min, pop_max, target_year)
    bookend_years_diff = get_year_difference(pop_min.year.year, pop_max.year.year)
    target_years_diff = get_year_difference(pop_min.year.year, target_year)
    pop_diff = get_pop_difference(pop_min.population, pop_max.population)
    pop_delta = get_pop_delta(pop_diff, bookend_years_diff)
    target_pop = pop_min.population + multiply_pops_by_year(pop_delta, target_years_diff)

    Population.new(year: Date.new(target_year), population: target_pop)
  end

  def self.future_pop_exponential(last_known_pop, target_year)
    if target_year > 2500
      throw ArgumentError "Can only estimate years up to the year 2500"
    end

    year_diff = get_year_difference(last_known_pop.year.year, target_year)
    pop_start = last_known_pop.population

    pop_multiplier = (1 + @estimated_future_growth_rate) ** year_diff
    estimated_pop = (pop_start * pop_multiplier).to_i
    Population.new year: Date.new(target_year), population: estimated_pop
  end

  def self.carrying_capacity_ratio(population)
    (@@carrying_capacity - population).to_f / @@carrying_capacity
  end

  def self.logistic_pop_for_year(year, target_year, population)
    return population if year == target_year

    capacity_ratio = carrying_capacity_ratio(population)
    pop_delta = @estimated_future_growth_rate * capacity_ratio * population
    logistic_pop_for_year(year + 1, target_year, pop_delta + population)
  end

  def self.future_pop_logistic(last_known_pop, target_year)
    if target_year > 2500
      throw ArgumentError "Can only estimate years up to the year 2500"
    end

    start_pop = last_known_pop.population
    start_year = last_known_pop.year.year
    estimated_pop = logistic_pop_for_year(start_year, target_year, start_pop)
    Population.new year: Date.new(target_year), population: estimated_pop
  end
end
