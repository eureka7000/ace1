Rails.application.routes.draw do

  resources :payments
    devise_for :users, :controllers => {:registrations => "registrations", :sessions=>"sessions", :confirmations => "confirmations"}
  	#devise_for :users
	
    root :to => "homes#index"

    get "mypages/overall" => "mypages#overall"
    
    # Mypages
    get 'mypages/settings' => "mypages#settings"  
    
    resources :users  

end
