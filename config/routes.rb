# frozen_string_literal: true

Rails.application.routes.draw do
  root 'profiles#index'

  resources :profiles do
    resources :naps do
      get 'calculate_schedule', on: :member
      post 'save_result', on: :member
    end
  end
end
