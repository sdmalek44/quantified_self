class FoodPresenter

  def initialize(food_id)
    @food = Food.find_by(id: food_id)
  end

  def food
    @food
  end

  def status
    return 200 if @food
    404
  end

end
