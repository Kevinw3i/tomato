Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  
  #counter
  resources :tictacs, only: [:index, :update] do
    collection do
      get :list
    end
    # tictac list edit
    member do
      get :cancelled
      get :finished
    end
  end
  
  #project
  resources :projects do
    resources :tasks, except: [:index] do
      member do
        patch :drag
        patch :toggle_status
      end
    end
  end

  resources :tasks, only: [] do
    collection do
      post :today_task
      post :cancelled_tictac
      post :finished_tictac
    end
    resource :tictac, only: [:show]
  end

  #API
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
  
  #homepage
  resources :home, only: [:index] do
    collection do
      get :todo
    end
  end

  #charts
  resources :charts, only: [:index]
  #trello
  resources :trelloapi, only: [:index] do
    collection do
      post :get_boards
      post :get_lists
      post :get_cards
      get :import_selection
      get :select_list_cards
    end
  end
end
