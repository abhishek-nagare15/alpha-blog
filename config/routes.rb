Rails.application.routes.draw do
  root 'pages#homepage'
  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
end
