Rails.application.routes.draw do
  
  root "movies#index" 
  resources :movies
  # Routes for the Movie resource:

end
