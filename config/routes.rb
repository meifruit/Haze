Rails.application.routes.draw do
  get 'reviews/create'
  devise_for :users
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "pages#home"

  resources :services, only: [:index, :show, :new, :create, :destroy] do
    member do
      get 'toggle_favorite', to: "services#toggle_favorite"
    end
    resources :bookings, except: [:destroy, :index, :edit, :update]
    resources :reviews, only: [:create]
  end
  resources :reviews, only: [:destroy]
  resources :bookings, only: [:destroy, :index, :edit, :update]

  get 'wishlist', to: 'services#wishlist', as: 'wishlist'
end

# create route
# create action for route wishlist in services controller
# load all users favorites into the instance variable
# create a view for the wishlist
# render list partial
# add link to navbar
