require 'rails_helper'

RSpec.describe Meal, type: :model do
  it {should have_many :food_meals}
  it {should have_many :foods}
end
