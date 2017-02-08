class Question < ActiveRecord::Base

    belongs_to :user
    belongs_to :unit_concept

    has_many :replies, :dependent => :delete_all
    
    mount_uploader :file_name, ImageUploader

    def self.get_question_number(current_user_id)
        questions_number = 0
        @related_users = UserRelation.where('related_user_id = ?', current_user_id)
        @related_users.each do |related_user|
            related_user.user.questions.each do |question|
                if question.confirm_yn == 'N'
                    questions_number += 1
                end
            end
        end
        questions_number
    end

    def self.get_questions(current_user_id, page)

        str = "select a.id, a.unit_concept_id, a.user_id, a.title, a.content, a.file_name, a.confirm_yn, a.like, a.width, a.height, a.created_at, a.updated_at
                from questions a, user_relations b
                where b.related_user_id = #{current_user_id}
                and b.user_id = a.user_id
                order by a.created_at desc"
        Question.paginate_by_sql(str, :page => page, :per_page => 20)
    end

    def self.get_question_user(current_user_id, current_user_type)
        str = "select distinct c.user_id from (select a.id, a.unit_concept_id, a.user_id , a.title, a.content, a.file_name, a.confirm_yn, a.like, a.width, a.height, a.created_at, a.updated_at
                from questions a, user_relations b
                where b.relation_type = '#{current_user_type}'
                and b.related_user_id = #{current_user_id}
                and a.user_id = b.user_id
                order by a.created_at desc ) c"
        students = Question.find_by_sql(str)

        students
    end

    def self.get_question_code(current_user_id, current_user_type)
        str = "select distinct c.unit_concept_id from (select a.id, a.unit_concept_id, a.user_id , a.title, a.content, a.file_name, a.confirm_yn, a.like, a.width, a.height, a.created_at, a.updated_at
                from questions a, user_relations b
                where b.relation_type = '#{current_user_type}'
                and b.related_user_id = #{current_user_id}
                and a.user_id = b.user_id
                order by a.created_at desc ) c"
        unit_concept = Question.find_by_sql(str)

        unit_concept
    end

    def self.get_question_from_search(current_user_id, student_id, unit_concept_id, page)
        str = "select a.id, a.unit_concept_id, a.user_id, a.title, a.content, a.file_name, a.confirm_yn, a.like, a.width, a.height, a.created_at, a.updated_at
                from questions a, user_relations b
                where b.related_user_id = #{current_user_id}
                and b.user_id = a.user_id"

        unless student_id.blank?
            str += " and a.user_id = #{student_id}"
        end

        unless unit_concept_id.blank?
            str += " and a.unit_concept_id = #{unit_concept_id}"
        end

        str += " order by a.created_at desc"


        Question.paginate_by_sql(str, :page => page, :per_page => 20)
    end

end