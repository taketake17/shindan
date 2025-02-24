Rails.application.routes.draw do
  get "users/show"
  devise_for :users, controllers: {
    registrations: "users/registrations"
   }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :questions
  root "questions#index"
  get "questions/result", to: "questions#show", as: "question_result" # または専用のresultアクションを作成


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
