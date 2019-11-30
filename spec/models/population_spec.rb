require 'rails_helper'

RSpec.describe Population, type: :model do

  it "should accept a year we know and return the correct population" do
    expect(Population.get(1900)).to eq(76212168)
    expect(Population.get(1990)).to eq(248709873)
  end

  it "should accept a year we don't know and return an estimate based on the calculations" do
    expect(Population.get(1902)).to eq(79415432)
    expect(Population.get(1908)).to eq(89025224)
  end

  it "should accept a year that is before earliest known and return zero" do
    expect(Population.get(1800)).to eq(0)
    expect(Population.get(0)).to eq(0)
    expect(Population.get(-1000)).to eq(0)
  end

  it "should accept a year that is after latest known and return an estimate based on exponential growth" do
    expect(Population.get(2000)).to eq(588786718)
    expect(Population.get(2050)).to eq(43780720267)
  end

end
