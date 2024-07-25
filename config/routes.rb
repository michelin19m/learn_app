Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :skills do
    resources :resources, except: [:index], shallow: true do
      resources :parts, except: [:index], shallow: true do
        resources :tests, only: [:index, :show, :new, :create, :destroy], shallow: true do
          get 'take_quiz', on: :member, to: 'tests#take_quiz'
          post 'submit_quiz', on: :member, to: 'tests#submit_quiz'
          get 'quiz_results', on: :member, to: 'tests#quiz_results'
        end
        post 'create_quiz', on: :member
      end
    end
  end

  # Additional custom route for generating questions
  get 'tests/generate_questions', to: 'tests#generate_questions'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "skills#index"
end
