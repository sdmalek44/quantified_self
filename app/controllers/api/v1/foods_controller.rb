class Api::V1::FoodsController < ApplicationController
  def index
    render json: Food.all
  end

  def show
    presenter = FoodPresenter.new(params[:id])
    render json: presenter.food, status: presenter.status
  end
end
