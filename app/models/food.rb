class Food < ApplicationRecord
  validates_presence_of :calories, :name
  has_many :food_meals
  has_many :meals, through: :food_meals
end
