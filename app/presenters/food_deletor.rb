class FoodDeletor
  def initialize(food_id)
    @food = Food.find_by(id: food_id)
  end

  def status
    return 404 if @food.nil?
    @food.destroy
    204
  end
end
