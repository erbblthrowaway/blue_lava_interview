class PopulationCalculator
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

  def self.get_population_for_year(pop_min, pop_max, target_year)
    bookend_years_diff = get_year_difference(pop_min.year.year, pop_max.year.year)
    target_years_diff = get_year_difference(pop_min.year.year, target_year)
    pop_diff = get_pop_difference(pop_min.population, pop_max.population)
    pop_delta = get_pop_delta(pop_diff, bookend_years_diff)
    target_pop = pop_min.population + multiply_pops_by_year(pop_delta, target_years_diff)

    Population.new(year: Date.new(target_year), population: target_pop)
  end
end
