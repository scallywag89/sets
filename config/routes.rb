Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :stacks, only: [:show, :edit, :update] do
    resources :stack_albums, only: [:create]
  end
  resources :stack_albums, only: [:destroy]

  resources :albums, only: [:create, :index, :show] do
    resources :tracks, only: [:create]
  end

  resources :setlists do
    resources :set_tracks, only: [:create]
  end
  resources :set_tracks, only: [:destroy]
end
