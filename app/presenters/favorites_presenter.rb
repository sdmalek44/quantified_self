class FavoritesPresenter

  def serialize_food(food)
    {
      name: food.name,
      calories: food.calories,
      mealsWhenEaten: food.meals.map {|meal| meal.name }
    }
  end

  def time_food
    {foods: []}
  end

  def serialize_foods(foods)
    foods.inject([]) do |col, food|
      if col[0].nil? || equal?(0, col, food)
        col[0] = time_food if col[0].nil?
        col[0][:timesEaten] = food.times_eaten
        col[0][:foods] << serialize_food(food)
      elsif col[1].nil? || equal?(1, col, food)
        col[1] = time_food if col[1].nil?
        col[1][:timesEaten] = food.times_eaten
        col[1][:foods] << serialize_food(food)
      elsif col[2].nil? || equal?(2, col, food)
        col[2] = time_food if col[2].nil?
        col[2][:timesEaten] = food.times_eaten
        col[2][:foods] << serialize_food(food)
      end
      col
    end
  end

  def equal?(index, arr, food)
    return false unless arr[index]
    arr[index][:timesEaten] == food.times_eaten
  end

  def favorites
    foods = Food.select("foods.*, count(meals.id) AS times_eaten")
            .joins(:meals)
            .group("foods.id")
            .having("count(meals.id) > 1")
            .order("times_eaten DESC")

    serialize_foods(foods)
  end


end
