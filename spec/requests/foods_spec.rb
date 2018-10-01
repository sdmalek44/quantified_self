require 'rails_helper'

describe '/api/v1' do
  context 'user visits /api/vi/foods' do
    it 'can see all foods' do
      food = Food.create!(name: 'cheese', calories: 1000)

      get '/api/v1/foods'

      foods = JSON.parse(response.body, symbolize_names: true)
      food_info = foods.first

      expect(foods.count).to eq(1)
      expect(food_info[:id]).to eq(food.id)
      expect(food_info[:name]).to eq(food.name)
      expect(food_info[:calories]).to eq(food.calories)
    end
  end
  context 'user visits /api/v1/foods/:id' do
    it 'can see one food' do
      food = Food.create!(name: 'cheese', calories: 1000)

      get "/api/v1/foods/#{food.id}"

      food_info = JSON.parse(response.body, symbolize_names: true)

      expect(food_info[:id]).to eq(food.id)
      expect(food_info[:name]).to eq(food.name)
      expect(food_info[:calories]).to eq(food.calories)
    end
    it 'gets 404 if no food' do
      get "/api/v1/foods/1"

      expect(response.status).to eq(404)
    end
  end
end
