class UserMailer < ApplicationMailer
    
    default from: "eureka6001@gmail.com"
    
    def cert_teacher(school_manager, user)
        @school_manager = school_manager
        @user = user
        mail(to: school_manager.email, subject: '교사 확인요청')
    end
    
    def noti_question(mento, user, question)
        @mento = mento
        @user = user
        @unit_concept = UnitConcept.find(question.unit_concept_id)
        @question = question
        mail(to: mento.email, subject: "[Eureka Math] #{user.user_name}학생의 질문이 도착하였습니다.")
    end    
    
end
