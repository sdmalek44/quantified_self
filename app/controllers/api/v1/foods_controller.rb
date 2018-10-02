class Api::V1::FoodsController < ApplicationController
  def index
    render json: Food.all
  end

  def show
    fp = FoodPresenter.new(params[:id])
    render json: fp.food, status: fp.status
  end

  def create
    fc = FoodCreator.new(food_params)
    render json: fc.food, status: fc.status
  end

  private

  def food_params
    params.require(:food).permit(:name, :calories)
  end
end
