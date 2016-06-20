Rails.application.routes.draw do

  resources :unit_concept_self_evaluations
    resources :blogs
    resources :unit_concept_exercise_solutions

    get '/grade_unit_concepts/get_chapters' => 'grade_unit_concepts#get_chapters' 
    get '/grade_unit_concepts/get_categories' => 'grade_unit_concepts#get_categories' 
    get '/grade_unit_concepts/get_sub_categories' => 'grade_unit_concepts#get_sub_categories'
    get '/grade_unit_concepts/get_unit_concepts' => 'grade_unit_concepts#get_unit_concepts'
    resources :grade_unit_concepts
    
    get 'concepts/:id/exercise' => 'concepts#exercise'
    resources :unit_concept_descs
    resources :concept_exercises
    resources :explanations
    resources :unit_concepts
    resources :contents
    
    get '/concepts/get_concepts' => 'concepts#get_concepts'
    get '/concepts/get_unit_concepts' => 'concepts#get_unit_concepts'
    resources :concepts
    resources :schools
    resources :payments
    resources :teachers
  
    devise_for :users, :controllers => {:registrations => "registrations", :confirmations => "confirmations"}
  	#devise_for :users

    # sub_pages of main
    get 'homes/history_of_eureka' => 'homes#history_of_eureka'
    get 'homes/eureka_motto' => 'homes#eureka_motto'
    get 'homes/self_directed_learning' => 'homes#self_directed_learning'
    get 'homes/math_renouncer' => 'homes#math_renouncer'
    get 'homes/goal_setting' => 'homes#goal_setting'
    get 'homes/program_selection' => 'homes#program_selection'
    get 'homes/do_study' => 'homes#do_study'
    get 'homes/educational_evaluation' => 'homes#educational_evaluation'
    get 'homes/how' => 'homes#how'
    get 'homes/access_terms' => 'homes#access_terms'
    get 'homes/personal_info_protection' => 'homes#personal_info_protection'

    root :to => "homes#index"

    get "mypages/overall" => "mypages#overall"
    
    # Mypages
    get 'mypages/settings' => "mypages#settings"  
    
    resources :users  
    post 'users/cert_teacher' => 'users#cert_teacher'
    
    get 'admins/login' => 'admins#login'
    get 'admins/logout' => 'admins#logout'
    post 'admins/sign_in' => 'admins#sign_in'
    get 'admins/main' => 'admins#main'
    post 'admins/change_password' => 'admins#change_password'
    resources :admins

end
