class FoodCreator
  def initialize(food_info)
    @food = Food.create(name: food_info[:name],
                        calories: food_info[:calories])
  end

  def food
    @food if @food.save
  end

  def status
    return 201 if @food.save
    400
  end
end
