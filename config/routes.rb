Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: 'api' do
    namespace :v1 do
      resources :badges
      resources :practices
      resources :rostereds
      resources :surveys
      resources :team_calculations
      resources :teams
      resources :player_calculations
      resources :events
    end
  end
end
