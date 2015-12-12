require 'bcrypt'

class Admin < ActiveRecord::Base
    
    include BCrypt
    
    def password
        @password ||= Password.new(password_hash)
    end    
    
    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end
    
    def create
#       @admin = Admin.new(params[:admin][:user]) 

        
    end    
    
end
