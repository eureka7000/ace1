class UserMailer < ApplicationMailer
    
    default from: "ghawk000@gmail.com"
    
    def cert_teacher(school_manager, user)
        mail(to: school_manager.email, subject: '교사 확인요청')
    end    
    
end
