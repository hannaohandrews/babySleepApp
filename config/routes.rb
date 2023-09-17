Rails.application.routes.draw do
  root "naps#index"
  resources :naps

  get '/calculate_schedule/:id', to: 'naps#calculate_schedule', as: :calculate_schedule
  post '/save_result', to: 'naps#save_result', as: :save_result
end
