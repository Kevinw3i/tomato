Rails.application.routes.draw do
  root "tasks#index"
  devise_for :users
  #counter
  resources :tictacs, only: [:index, :show]
  
  #task
  resources :tasks
  #project
  resources :projects

  #Api
  namespace :api do
    namespace :v1 do
      resources :tictacs, only: [] do
        collection do
          post :start
        end
        member do
          post :cancel
          post :finish
        end
      end
    end
  end

end
