class Api::V1::MealsController < ApplicationController
  def index
    render json: Meal.all
  end

  def show
    mp = MealPresenter.new(params[:meal_id])
    render json: mp.meal_foods, status: mp.status
  end

  def create
    mc = MealCreator.new(meal_params)
    render json: mc.message, status: mc.status
  end

  def destroy
    mr = FoodRemover.new(meal_params)
    render json: mr.message, status: mr.status
  end

  private

  def meal_params
    params.permit(:meal_id, :id)
  end
end
