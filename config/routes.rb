Ideaspot::Application.routes.draw do
  get "polls/index"

  resources :polls
  resources :ideas
  resources :comments

  root :to => 'polls#new'
end
