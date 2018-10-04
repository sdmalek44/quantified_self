# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
meal1 = Meal.create!(name: 'Breakfast')
food1 = meal1.foods.create!(name: 'Banana', calories: 150)
food2 = meal1.foods.create!(name: 'Meatloaf', calories: 800)
food3 = meal1.foods.create!(name: 'Donut', calories: 500)
food4 = meal1.foods.create!(name: 'Bread', calories: 150)
meal2 = Meal.create!(name: 'Lunch')
meal2.food_meals.create!(food_id: food1.id)
meal2.food_meals.create!(food_id: food2.id)
meal2.food_meals.create!(food_id: food3.id)
meal3 = Meal.create!(name: 'Dinner')
meal3.food_meals.create!(food_id: food1.id)
meal3.food_meals.create!(food_id: food2.id)
meal3.food_meals.create!(food_id: food4.id)
