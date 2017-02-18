Rails.application.routes.draw do

    resources :exam_images
    get '/exams/previous_exams' => 'exams#previous_exams'
    get '/exams/list'=> 'exams#list'
    resources :exams
    resources :textbooks
    resources :coupons

    get 'concept_exercise_solution_links/create'
    get 'concept_exercise_solution_links/update'

    resources :concept_exercise_solution_links

    get 'unit_concept_desc_solution_links/create'
    get 'unit_concept_desc_solution_links/update'

    resources :unit_concept_desc_solution_links

    resources :blog_replies

    get '/prints/get_question_list' => 'prints#get_question_list'
    get '/prints/solutions' => 'prints#solutions'
    get '/prints/get_solution_list' => 'prints#get_solution_list'
    get '/prints/exercises' => 'prints#exercises'
    get '/prints/get_exercise_list' => 'prints#get_exercise_list'
    resources :prints

    get '/study_histories/detail' => 'study_histories#detail'
    resources :study_histories

    resources :inicis_payments
    resources :user_types
    resources :concept_exercises
    resources :replies

    get 'questions/questions_list' => 'questions#questions_list'
    get 'questions/:id/like' => 'questions#like'
    resources :questions

    post 'user_relations/approval' => 'user_relations#approval'
    post 'user_relations/rejection' => 'user_relations#rejection'
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
    # get '/unit_concept_descs/get_not_saved_images' => 'unit_concept_descs#get_not_saved_images'
    resources :unit_concept_descs
    resources :explanations
    resources :unit_concepts

    get '/contents/exercise' => 'contents#exercise'
    get '/contents/get_chapter_list' => 'contents#get_chapter_list'
    get '/contents/by_level' => 'contents#by_level'
    get '/contents/get_grade_list' => 'contents#get_grade_list'
    get 'contents/math_jax' => 'contents#math_jax'
    resources :contents

    get '/concepts/get_concepts' => 'concepts#get_concepts'
    get '/concepts/get_unit_concepts' => 'concepts#get_unit_concepts'
    resources :concepts
    resources :schools

    get  'payments/close' => 'payments#close'
    post 'payments/payment_return' => 'payments#payment_return'
    post 'payments/paypal' => 'payments#paypal'
    get  'payments/paypal_payment_return' => 'payments#paypal_payment_return'
    post 'payments/paypal_confirm' => 'payments#paypal_confirm'
    # post 'payments/textbook' => 'payments#textbook'
    resources :payments

    get 'teachers/students_list' => 'teachers#students_list'
    resources :teachers

    devise_for :users, :controllers => {:registrations => "registrations", :confirmations => "confirmations", :sessions => "sessions", omniauth_callbacks: 'omniauth_callbacks'}
    # match 'users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
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
    get 'homes/contents_list' => 'homes#contents_list'
    root :to => "homes#index"

    # Mypages
    get  'mypages/overall' => 'mypages#overall'
    get  'mypages/evaluation' => 'mypages#evaluation'
    get  'mypages/user_info' => 'mypages#user_info'
    get  'mypages/question_list' => 'mypages#question_list'
    get  'mypages/payment' => 'mypages#payment'
    post 'mypages/user_image_upload' => 'mypages#user_image_upload'
    get  'mypages/student_management' => 'mypages#student_management'
    get  'mypages/study_progress_detail' => 'mypages#study_progress_detail'
    get  'mypages/request_textbook' => 'mypages#request_textbook'
    post 'mypages/get_textbook_price' => 'mypages#get_textbook_price'
    post 'mypages/find_school_admin' => 'mypages#find_school_admin'
    post 'mypages/self_evaluation_show' => 'mypages#self_evaluation_show'
    match 'mypages/juso_popup' => 'mypages#juso_popup', via: [:get, :post]

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
    post 'blogs/contact_us_message' => 'blogs#contact_us_message'
    get 'blogs/recommendation' => 'blogs#recommendation'
    get 'blogs/sign_in_process' => 'blogs#sign_in_process'
    get 'blogs/:id/like' => 'blogs#like'
    get 'blogs/how_to_purchase_textbook' => 'blogs#how_to_purchase_textbook'
    get 'blogs/how_to_purchase_membership' => 'blogs#how_to_purchase_membership'
    resources :blogs

    get 'users/get_mento' => 'users#get_mento'
    post 'users/update_admin' => 'users#update_admin'
    get 'users/multi_auth' => 'users#multi_auth'
    post 'users/multi_auth' => 'users#multi_auth_create'
    get  'users/resend_mail' => 'users#resend_mail'
    post 'users/user_exist' => 'users#user_exist'
    get  'users/user_profile' => 'users#user_profile'
    resources :users
    post 'users/cert_teacher' => 'users#cert_teacher'
    post 'users/create' => 'users#create'

    get 'admins/login' => 'admins#login'
    get 'admins/logout' => 'admins#logout'
    post 'admins/sign_in' => 'admins#sign_in'
    get 'admins/main' => 'admins#main'
    get 'admins/main_for_manager' => 'admins#main_for_manager'
    post 'admins/change_password' => 'admins#change_password'
    get 'admins/users' => 'admins#users'
    resources :admins

    get 'home/math1' => 'homes#index'

end
