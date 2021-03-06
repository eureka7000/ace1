class UserMailer < ApplicationMailer
    
    default from: "info@eurekamath.co.kr"
    
    def cert_teacher(school_manager, user)
        @school_manager = school_manager
        @user = user
        mail(to: school_manager.email, subject: '교사 확인요청')
    end
    
    def noti_question(mento, user, question, concept)
        @mento = mento
        @user = user
        @concept = concept

        @unit_concept = UnitConcept.find(question.unit_concept_id)

        @question = question
        mail(to: mento.email, subject: "[Eureka Math] #{user.user_name}학생의 질문이 도착하였습니다.")
    end
    
    def request_relation(to_user, user, relation)
        @to_user = to_user
        @user = user
        @relation = relation
        mail(to: to_user.email, subject: "[Eureka Math] #{user.user_name}님이 귀하에게 #{relation.relation_type}관계를 요청하였습니다.")
    end

    def noti_reply(mentee, user, question)
        @mentee = mentee
        @user = user
        @question = question

        mail(to: mentee.email, subject: "[Eureka Math] #{user.user_name} 선생님의 답변이 도착하였습니다.")
    end

    def noti_contact_us_message(user, blog)
        @user = user
        @blog = blog

        mail(to: 'info@eurekamath.co.kr', subject: "[문의사항] #{user.user_name} 님의 문의사항이 도착하였습니다." )
    end
end
