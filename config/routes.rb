# frozen_string_literal: true

Rails.application.routes.draw do
  root "student_dashboards#show"
  resources :student_dashboards, only: [:show]
  devise_for :student_logins, controllers: { omniauth_callbacks: 'student_logins/omniauth_callbacks' }

  devise_scope :student_login do
    get 'student_logins/sign_in', to: 'student_logins/sessions#new', as: :new_student_login_session
    get 'student_logins/sign_out', to: 'student_logins/sessions#destroy', as: :destroy_student_login_session
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
