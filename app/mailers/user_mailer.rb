class UserMailer < ApplicationMailer
    
    default from: "eureka6001@gmail.com"
    
    def cert_teacher(school_manager, user)
        @school_manager = school_manager
        @user = user
        mail(to: school_manager.email, subject: '교사 확인요청')
    end    
    
end
