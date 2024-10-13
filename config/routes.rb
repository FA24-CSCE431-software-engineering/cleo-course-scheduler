Rails.application.routes.draw do
  resources :courses do
    member do
      get :confirm_destroy
    end
  end

  resources :majors do
    member do
      get :confirm_destroy
    end
  end

  resources :core_categories do
    member do
      get :confirm_destroy
    end
  end

  # root "student_dashboards#show"
  resources :student_dashboards, only: [:show]
  devise_for :student_logins, controllers: { omniauth_callbacks: 'student_logins/omniauth_callbacks' }

  devise_scope :student_login do
    get 'student_logins/sign_in', to: 'student_logins/sessions#new', as: :new_student_login_session
    get 'student_logins/sign_out', to: 'student_logins/sessions#destroy', as: :destroy_student_login_session
  end
  
  # Student dashboard (regular users)
  resources :student_dashboards, only: [:show], param: :google_id, path: 'student_dashboard'

  # Admin dashboard
  namespace :admin do
    resources :tracks
    resources :emphases
    get 'dashboard', to: 'dashboard#show', as: :dashboard
  end

  # CRUD routes for track & emphasis
  resources :tracks
  resources :emphases

  get 'degree_plan', to: 'def_degree#show', as: 'degree_plan'
  post 'save_degree_plan', to: 'def_degree#save', as: 'save_degree_plan'
  get 'download_degree_plan', to: 'def_degree#download', as: 'download_degree_plan'
  get 'path_to_savedplanner', to: 'def_degree#savedplanner', as: 'saved_degree_planner'

  # for student courses
  resources :student_courses, param: :student_id do
    get ':course_id', action: :show, on: :member
    get ':course_id/edit', action: :edit, on: :member, as: 'edit'
    patch ':course_id', action: :update, on: :member
    delete ':course_id', action: :destroy, on: :member
  end

  # Students resources with profile and degree planner
  resources :students, param: :google_id do
    member do
      get 'profile'
      get 'edit'
      get 'confirm_destroy'
    end
  
    resource :degree_planner, only: [:show], controller: 'degree_planners' do
      patch :update_plan, on: :member
      post :generate_custom_plan, on: :member
      delete 'remove_course', on: :member
      post 'download_plan', on: :member, to: 'degree_planners#download_plan'
      
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

  resources :def_degree, only: [:show, :new, :create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'courses/:id', to: 'courses#show'
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest'


  # Defines the root path route ("/")
end
