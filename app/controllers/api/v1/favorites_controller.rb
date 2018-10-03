class Api::V1::FavoritesController < ApplicationController
  def index
    fp = FavoritesPresenter.new
    render json: fp.favorites
  end
end
