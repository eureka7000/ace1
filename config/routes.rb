Rails.application.routes.draw do

    get '/study_histories/detail' => 'study_histories#detail'
    resources :study_histories
    
    
    resources :inicis_payments
    resources :user_types
    resources :concept_exercises
    resources :replies
    get 'questions/questions_list' => 'questions#questions_list'
    resources :questions
    resources :user_relations
    resources :unit_concept_self_evaluations
    resources :unit_concept_exercise_solutions
    resources :unit_concept_exercise_histories

    get '/grade_unit_concepts/get_chapters' => 'grade_unit_concepts#get_chapters' 
    get '/grade_unit_concepts/get_categories' => 'grade_unit_concepts#get_categories' 
    get '/grade_unit_concepts/get_sub_categories' => 'grade_unit_concepts#get_sub_categories'
    get '/grade_unit_concepts/get_unit_concepts' => 'grade_unit_concepts#get_unit_concepts'
    get '/grade_unit_concepts/get_concepts' => 'grade_unit_concepts#get_concepts'
    resources :grade_unit_concepts
    
    get 'concepts/:id/exercise' => 'concepts#exercise'
    resources :unit_concept_descs
    resources :explanations
    resources :unit_concepts
    
    get '/contents/exercise' => 'contents#exercise'
    resources :contents
    
    get '/concepts/get_concepts' => 'concepts#get_concepts'
    get '/concepts/get_unit_concepts' => 'concepts#get_unit_concepts'
    resources :concepts
    resources :schools

    get 'payments/close' => 'payments#close'
    post 'payments/payment_return' => 'payments#payment_return'
    resources :payments

    get 'teachers/students_list' => 'teachers#students_list'
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

    # Mypages
    get 'mypages/evaluation' => 'mypages#evaluation'
    get 'mypages/user_info' => 'mypages#user_info'
    get 'mypages/question_list' => 'mypages#question_list'
    get 'mypages/payment' => 'mypages#payment'
    post 'mypages/user_image_upload' => 'mypages#user_image_upload'
    get 'mypages/study_progress_check' => 'mypages#study_progress_check'

    # blogs
    get 'blogs/learning_problem_solution' => 'blogs#learning_problem_solution'
    get 'blogs/succession_case' => 'blogs#succession_case'
    get 'blogs/math_story' => 'blogs#math_story'
    get 'blogs/faq' => 'blogs#faq'
    get 'blogs/notice' => 'blogs#notice'
    get 'blogs/the_news' => 'blogs#the_news'
    get 'blogs/company_introduction' => 'blogs#company_introduction'
    get 'blogs/video_function_extension' => 'blogs#video_function_extension'
    get 'blogs/studying_screen_explanation' => 'blogs#studying_screen_explanation'
    get 'blogs/contact_us' => 'blogs#contact_us'
    get 'blogs/recommendation' => 'blogs#recommendation'
    resources :blogs

    get 'users/get_mento' => 'users#get_mento'
    post 'users/update_admin' => 'users#update_admin'
    get 'users/multi_auth' => 'users#multi_auth'
    post 'users/multi_auth' => 'users#multi_auth_create'
    resources :users  
    post 'users/cert_teacher' => 'users#cert_teacher'
    post 'users/create' => 'users#create'

    
    get 'admins/login' => 'admins#login'
    get 'admins/logout' => 'admins#logout'
    post 'admins/sign_in' => 'admins#sign_in'
    get 'admins/main' => 'admins#main'
    post 'admins/change_password' => 'admins#change_password'
    resources :admins

end
