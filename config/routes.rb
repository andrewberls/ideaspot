Ideaspot::Application.routes.draw do

  resources :polls do
    resources :comments
  end

  resources :ideas

  root :to => 'polls#new'
end
