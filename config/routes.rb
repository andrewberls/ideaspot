Ideaspot::Application.routes.draw do

  resources :polls do
    resources :comments
    resources :ideas
  end


  root :to => 'polls#new'
  match 'join' => 'polls#join', as: 'join_poll'
  match '/polls/:id' => 'polls#show', as: 'show_poll'


end
