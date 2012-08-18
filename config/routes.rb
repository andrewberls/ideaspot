Ideaspot::Application.routes.draw do
  resources :polls
  resources :ideas
  resources :comments

  root :to => 'polls#new'
end
