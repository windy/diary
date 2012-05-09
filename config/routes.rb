App::Application.routes.draw do

  devise_for :users

  resources :diaries do
    collection do
      post :preview
    end
  end

  root :to=> "diaries#index"
end
