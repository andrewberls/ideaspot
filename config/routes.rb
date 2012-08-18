Ideaspot::Application.routes.draw do

  resources :polls do
    resources :comments
  end

  resources :ideas

  root :to => 'polls#new'
  match 'join' => 'polls#join', as: 'join_poll'
  match '/polls/:id' => 'polls#show', as: 'show_poll'


end
