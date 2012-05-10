App::Application.routes.draw do

  devise_for :users

  match '/about'=> 'home#about'

  resources :diaries do
    collection do
      post :preview
    end
  end

  match '/:user'=> 'diaries#user_index'

  root :to=> "diaries#index"
end
