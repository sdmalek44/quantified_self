Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :foods, only: [:index, :show, :create, :update, :destroy]
      resources :meals, only: [:index]
      post "/meals/:meal_id/foods/:id", to: "meals#create"
      get "/meals/:meal_id/foods", to: "meals#show"
      delete "/meals/:meal_id/foods/:id", to: "meals#destroy"
    end
  end
end
