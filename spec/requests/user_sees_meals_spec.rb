require 'rails_helper'

describe '/api/v1' do
  context 'get /api/v1/meals' do
    it 'can see meals' do
      food = Food.create!(name: 'Banana', calories: 150)
      meal = food.meals.create!(name: 'Breakfast')

      get '/api/v1/meals'

      meals = JSON.parse(response.body, symbolize_names: true)
      meal = meals.first

      expect(meals.count)
      expect(meal[:id]).to eq(1)
      expect(meal[:name]).to eq('Breakfast')
      expect(meal[:foods]).to be_a(Array)
      expect(meal[:foods][0][:name])
      expect(meal[:foods][0][:calories])
    end
  end
  context 'get /api/v1/meals/:id/foods' do
    it 'can see a specific meal' do
      food = Food.create!(name: 'Banana', calories: 150)
      meal = food.meals.create!(name: 'Breakfast')

      get "/api/v1/meals/#{meal.id}/foods"
      meals = JSON.parse(response.body, symbolize_names: true)
      meal = meals.first

      expect(meals.count).to eq(1)
      expect(meals).to be_a(Array)
      expect(meal[:id]).to eq(food.id)
      expect(meal[:name]).to eq(food.name)
      expect(meal[:calories]).to eq(food.calories)
    end
    it 'status 404 if not found' do
      get "/api/v1/meals/1/foods"

      expect(response.status).to eq(404)
    end
  end
  context 'post /api/v1/meals/:meal_id/foods/:id' do
    it 'can add a food to a meal' do
      food = Food.create!(name: 'Banana', calories: 150)
      meal = Meal.create!(name: 'Breakfast')

      post "/api/v1/meals/#{meal.id}/foods/#{food.id}"

      expect(response.status).to eq(201)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:message]).to eq("Successfully added #{food.name} to #{meal.name}")
    end
    it 'status 404 if not found' do
      post "/api/v1/meals/1/foods/1"

      expect(response.status).to eq(404)
    end
  end
  context 'delete /api/v1/meals/:meal_id/foods/:id' do
    it 'removes the food from the meal' do
      meal = Meal.create!(name: 'Breakfast')
      food = meal.foods.create!(name: 'Banana', calories: 150)
      food_name = food.name
      delete "/api/v1/meals/#{meal.id}/foods/#{food.id}"

      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:message]).to eq("Successfully removed #{food_name} from #{meal.name}")
    end
    it 'removes the food from the meal' do
      meal = Meal.create!(name: 'Breakfast')

      delete "/api/v1/meals/#{meal.id}/foods/1"

      expect(response.status).to eq(404)
    end
  end
end
