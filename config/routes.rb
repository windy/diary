App::Application.routes.draw do

  devise_for :users

  resources :diaries

  root :to=> "home#index"
end
