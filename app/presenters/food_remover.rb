class FoodRemover

  def initialize(meal_info)
    @meal = Meal.find_by(id: meal_info[:meal_id])
    @food_meal = @meal.food_meals.find_by(food_id: meal_info[:id]) if @meal
  end

  def remove_food
    @rf ||= @food_meal.destroy if @meal && @food_meal
  end

  def message
    if remove_food
      { message: "Successfully removed #{@food_meal.food.name} from #{@meal.name}"}
    end
  end

  def status
    return 200 if remove_food
    404
  end
end
