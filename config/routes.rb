Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :badges
  resources :practices
  resources :rostereds
  resources :surveys
  resources :team_calculations
  resources :teams
end
