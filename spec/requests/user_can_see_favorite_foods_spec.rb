require 'rails_helper'

describe 'visit /api/v1' do
  context '/api/v1/favorite_foods' do
    it 'can see all favorite foods sorted by times eaten' do
      meal1 = Meal.create!(name: 'Breakfast')
      food1 = meal1.foods.create!(name: 'Banana', calories: 150)
      food2 = meal1.foods.create!(name: 'Meatloaf', calories: 800)
      food3 = meal1.foods.create!(name: 'Donut', calories: 500)
      food4 = meal1.foods.create!(name: 'Bread', calories: 150)
      meal2 = Meal.create!(name: 'Lunch')
      meal2.food_meals.create!(food_id: food1.id)
      meal2.food_meals.create!(food_id: food2.id)
      meal3 = Meal.create!(name: 'Dinner')
      meal3.food_meals.create!(food_id: food1.id)
      meal3.food_meals.create!(food_id: food2.id)
      meal3.food_meals.create!(food_id: food4.id)

      get '/api/v1/favorite_foods'

      favorites = JSON.parse(response.body, symbolize_names: true)

      favorite = favorites.first

      expect(favorites.count).to eq(2)
      expect(favorite[:timesEaten]).to eq(3)
      expect(favorite[:foods]).to be_a(Array)
      expect(favorite[:foods][0][:name]).to eq('Meatloaf')
      expect(favorite[:foods][0][:calories]).to eq(800)
      expect(favorite[:foods][0][:mealsWhenEaten]).to be_a(Array)
      expect(favorite[:foods][0][:mealsWhenEaten].count).to eq(3)
      expect(favorite[:foods][0][:mealsWhenEaten][0]).to eq("Breakfast")
      expect(favorite[:foods][0][:mealsWhenEaten][1]).to eq("Lunch")
      expect(favorite[:foods][0][:mealsWhenEaten][2]).to eq("Dinner")
    end
  end
end
