Rails.application.routes.draw do

    devise_for :users, :controllers => {:registrations => "registrations", :sessions=>"sessions", :confirmations => "confirmations"}
  	#devise_for :users
	
    root :to => "homes#index"

    get "users/welcome" => "users#welcome"
    get "mypages/overall" => "mypages#overall"
    

end
