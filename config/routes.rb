# frozen_string_literal: true

Rails.application.routes.draw do

  # root "student_dashboards#show"
  resources :student_dashboards, only: [:show]
  devise_for :student_logins, controllers: { omniauth_callbacks: 'student_logins/omniauth_callbacks' }

  devise_scope :student_login do
    get 'student_logins/sign_in', to: 'student_logins/sessions#new', as: :new_student_login_session
    get 'student_logins/sign_out', to: 'student_logins/sessions#destroy', as: :destroy_student_login_session
  end

  # Student dashboard (regular users)
  resources :student_dashboards, only: [:show], path: 'student_dashboard'

  # Admin dashboard
  namespace :admin do
    get 'dashboard', to: 'dashboard#show', as: :dashboard
  end

  get 'degree_plan', to: 'def_degree#show', as: 'degree_plan'
  post 'save_degree_plan', to: 'def_degree#save', as: 'save_degree_plan'
  get 'download_degree_plan', to: 'def_degree#download', as: 'download_degree_plan'
  
  # for student courses
  resources :student_courses, param: :student_id do
    get ':course_id', action: :show, on: :member
    get ':course_id/edit', action: :edit, on: :member, as: 'edit'
    patch ':course_id', action: :update, on: :member
    delete ':course_id', action: :destroy, on: :member
  end
  

  resources :students do
    member do
      get 'profile'
      get 'edit'
      get 'confirm_destroy'
    end
  end

  # routing to the support pages
  resources :support do
    collection do
      get 'student'
      get 'admin'
      get 'deployment'
      get 'other'
    end
  end

  
  resources :def_degree, only: [:show]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
end
