Studdy::Application.routes.draw do
  root 'about#index'
  get "about", to: 'about#index'
  devise_for :users
  resources :subtopics
  resources :topics
  resources :listings
  resources :users, only: [:show]
  resources :notifications, only: [:create]
end