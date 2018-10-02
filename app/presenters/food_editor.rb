class FoodEditor
  def initialize(food_id, food_info)
    @food = Food.find_by(id: food_id)
    @updated = @food.update(name: food_info[:name],
                            calories: food_info[:calories])
  end

  def food
    @food if @updated
  end

  def status
    return 202 if @updated
    400
  end
end
