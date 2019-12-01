require 'rails_helper'

RSpec.describe PopulationCalculator do

  describe "get_year_difference" do
    it "returns the difference between years" do
      expected = 10
      actual = PopulationCalculator.get_year_difference 1950, 1960
      expect(actual).to eq(expected)
    end
  end

  describe "get_pop_difference" do
    it "returns the difference between two populations" do
      expected = 500
      actual = PopulationCalculator.get_pop_difference(1500, 2000)
      expect(actual).to eq(expected)
    end
  end

  describe "get_pop_delta" do
    it "returns the change per year over the course of years" do
      expected = 50.to_f
      actual = PopulationCalculator.get_pop_delta(500, 10)
      expect(actual).to eq(expected)
    end
  end

  describe "multiply_pops_by_year" do
    it "returns the projected population change over the time" do
      expected = 250
      actual = PopulationCalculator.multiply_pops_by_year(50, 5)
      expect(actual).to eq(expected)
    end
  end

  describe "estimated_pop_for_past_year" do
    it "returns the correct population for the projected year" do
      pop_min = Population.new year: Date.new(1950), population: 1500
      pop_max = Population.new year: Date.new(1960), population: 2000

      expected = Population.new year: Date.new(1955), population: 1750
      actual = PopulationCalculator.estimated_pop_for_past_year(pop_min, pop_max, 1955)

      expect(actual.year).to eq(expected.year)
      expect(actual.population).to eq(expected.population)
    end
  end

  describe "future_pop_exponential" do
    it "returns a value based off estimated growth rates" do
      pop_start = Population.new year: Date.new(1990), population: 100
      expected = Population.new year: Date.new(1991), population: 109
      actual = PopulationCalculator.future_pop_exponential(pop_start, 1991)

      expect(actual.year).to eq(expected.year)
      expect(actual.population).to eq(expected.population)

      expected = Population.new year: Date.new(1992), population: 118
      actual = PopulationCalculator.future_pop_exponential(pop_start, 1992)

      expect(actual.year).to eq(expected.year)
      expect(actual.population).to eq(expected.population)
    end
  end

  describe "future_pop_logistic" do
    it "returns a value based off logistic growth rates" do
      pop_start = Population.new year: Date.new(1990), population: 248709873
      expected = Population.new year: Date.new(1995), population: 327315265

      actual = PopulationCalculator.future_pop_logistic(pop_start, 1995)
      expect(actual.year).to eq(expected.year)
      expect(actual.population).to eq(expected.population)

      far_future = PopulationCalculator.future_pop_logistic(pop_start, 2450)
      expect(far_future.population).to be <= PopulationCalculator.carrying_capacity
    end
  end
end
