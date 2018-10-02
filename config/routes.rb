Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :foods, only: [:index, :show, :create, :update, :destroy]
      resources :meals, only: [:index, :show]
      post "/meals/:meal_id/foods/:id", to: "meals#create"
    end
  end
end
