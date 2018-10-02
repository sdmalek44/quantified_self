require 'rails_helper'

describe '/api/v1' do
  context 'get /api/vi/foods' do
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
  context 'get /api/v1/foods/:id' do
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
  context 'post /api/v1/foods/:id' do
    it 'can see created food' do
      payload = { "food": { "name": "cheerios", "calories": "123"} }

      post "/api/v1/foods", params: payload

      expect(response.status).to eq(201)
      expect(response).to be_successful

      food_info = JSON.parse(response.body, symbolize_names: true)

      expect(food_info[:id]).to eq(1)
      expect(food_info[:name]).to eq("cheerios")
      expect(food_info[:calories]).to eq(123)
    end
    it 'status 400 if it didnt create food' do
      payload = { "food": { "calories": "123"} }
      post "/api/v1/foods", params: payload

      expect(response.status).to eq(400)
    end
  end
  context 'patch /api/v1/foods/:id' do
    it 'can change the food info' do
      food = Food.create!(name: 'cheese', calories: 1000)
      payload = { "food": { "name": "cheerios", "calories": "123"} }

      patch "/api/v1/foods/#{food.id}", params: payload

      food_info = JSON.parse(response.body, symbolize_names: true)

      expect(food_info[:id]).to eq(food.id)
      expect(food_info[:name]).to eq("cheerios")
      expect(food_info[:calories]).to eq(123)
    end
    it 'status 400 if food not updated' do
      food = Food.create!(name: 'cheese', calories: 1000)
      payload = { "food": {"calories": "123"} }

      patch "/api/v1/foods/#{food.id}", params: payload

      expect(response.status).to eq(400)
    end
  end
  context 'delete /api/v1/foods/:id' do
    it 'can delete a food' do
      food = Food.create!(name: 'cheese', calories: 1000)

      delete "/api/v1/foods/#{food.id}"

      expect(response.status).to eq(204)
    end
    it 'status 404 if food not found' do
      delete "/api/v1/foods/1"

      expect(response.status).to eq(404)
    end
  end
end
