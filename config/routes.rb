# frozen_string_literal: true

Rails.application.routes.draw do

  root 'profiles#index'
  resources :naps
  resources :profiles do
    resources :naps
  end

  #for naps
  get '/nap_index', to:'naps#index', as: :nap_index
  get '/calculate_schedule/:id', to: 'naps#calculate_schedule', as: :calculate_schedule
  post '/save_result', to: 'naps#save_result', as: :save_result

  #for profiles
  post '/profiles', to: 'profiles#create', as:'create_profiles'
end
