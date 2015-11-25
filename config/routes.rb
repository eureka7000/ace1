Rails.application.routes.draw do

    devise_for :users, :controllers => {:registrations => "registrations", :sessions=>"sessions"}
  	#devise_for :users


	  root :to => "homes#index"

end
