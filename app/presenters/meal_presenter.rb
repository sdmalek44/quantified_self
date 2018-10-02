class MealPresenter
  def initialize(meal_id)
    @meal = Meal.find_by(id: meal_id)
  end

  def meal_foods
    @meal.foods if @meal
  end

  def status
    return 200 if @meal
    404
  end
end
