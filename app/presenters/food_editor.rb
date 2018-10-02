class FoodEditor
  def initialize(food_id, food_info)
    @food = Food.find_by(id: food_id)
    @did_update = @food.update(name: food_info[:name],
                            calories: food_info[:calories])
  end

  def food
    @food if @did_update
  end

  def status
    return 202 if @did_update
    400
  end
end
