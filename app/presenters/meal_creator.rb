class MealCreator
  def initialize(meal_info)
    @meal = Meal.find_by(id: meal_info[:meal_id])
    @food = Food.find_by(id: meal_info[:id])
  end

  def add_food_to_meal
    @fm ||= FoodMeal.create(food_id: @food.id, meal_id: @meal.id) if @meal && @food
  end

  def message
    if add_food_to_meal
      { message: "Successfully added #{@food.name} to #{@meal.name}" }
    end
  end

  def status
    return 201 if @food && @meal
    404
  end
end
