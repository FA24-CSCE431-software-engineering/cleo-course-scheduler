# frozen_string_literal: true

Rails.application.routes.draw do
  # root "student_dashboards#show"

  devise_for :student_logins, controllers: { omniauth_callbacks: 'student_logins/omniauth_callbacks' }

  devise_scope :student_login do
    get 'student_logins/sign_in', to: 'student_logins/sessions#new', as: :new_student_login_session
    get 'student_logins/sign_out', to: 'student_logins/sessions#destroy', as: :destroy_student_login_session
  end

  # Student dashboard (regular users)
  resources :student_dashboards, only: [:show], param: :google_id, path: 'student_dashboard'

  # Admin dashboard
  namespace :admin do
    resources :prerequisites do 
      member do
        get :confirm_destroy
      end
    end    
    resources :student_courses, param: :student_id do
      get ':course_id', action: :show, on: :member
      get ':course_id/edit', action: :edit, on: :member, as: 'edit'
      patch ':course_id', action: :update, on: :member
      delete ':course_id', action: :destroy, on: :member
    end
    resources :tracks
    resources :emphases
    resources :courses do
      member do
        get :confirm_destroy
      end
      collection do
        post :import
        get :view_template
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
    resources :support do
      collection do
        get 'index'
        get 'deployment'
        get 'coreCategories'
        get 'courses'
        get 'emphases'
        get 'enrollCourses'
        get 'tracks'
        get 'users'
      end
    end

    get 'dashboard', to: 'dashboard#show', as: :dashboard
  end

  # Degree plan routes
  get 'degree_plan', to: 'def_degree#show', as: 'degree_plan'
  post 'save_degree_plan', to: 'def_degree#save', as: 'save_degree_plan'
  get 'download_degree_plan', to: 'def_degree#download', as: 'download_degree_plan'
  get 'path_to_savedplanner', to: 'def_degree#savedplanner', as: 'saved_degree_planner'

  # Student courses
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
      get 'degree_planner', to: 'degree_planner#show'
      post 'degree_planner', to: 'degree_planner#generate_custom_plan'
    end

    resource :degree_planner, only: [:show], controller: 'degree_planner' do
      patch :update_plan, on: :member
      post :generate_custom_plan, on: :member
      delete 'remove_course', on: :member
      get :download_plan, on: :member
      delete :clear_courses, on: :member
      post :set_default, on: :member
      post :upload_plan, on: :member
      get :view_template, on: :member
    end
  end

  # Support pages
  resources :support do
    collection do
      get 'index'
      get 'buildPlan'
      get 'profile'
      get 'viewDefaultPlan'
    end
  end

  # Default degree routes
  resources :def_degree, only: %i[show new create]

  # Root route
  root 'home#index'
  get 'courses/:id', to: 'courses#show'

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check

  # PWA routes
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest'
end
