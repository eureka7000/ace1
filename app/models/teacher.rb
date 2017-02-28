class Teacher < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :school

    def self.get_students(school_id, page, teacher_name, student_name, order)

        query = "select tc.user_name as teacher_name, e.user_id as teacher_id, stu.user_name as student_name, stu.id as student_id, stu.email as student_email, tc.user_auth, stu.sign_in_count, stu.created_at
                from users tc, users stu, user_relations d, teachers e
                where e.school_id = #{school_id}
                and e.user_id = d.related_user_id
                and stu.id = d.user_id
                and tc.id = e.user_id"

        unless teacher_name.blank?
            query += " and tc.user_name like '%#{teacher_name}%'"
        end

        unless student_name.blank?
            query += " and stu.user_name like '%#{student_name}%'"
        end

        query += " order by"

        unless order.blank?
            if order == 'asc'
                query += " stu.sign_in_count asc,"
            else
                query += " stu.sign_in_count desc,"
            end
        end

        query += " teacher_name, student_name"

        Teacher.paginate_by_sql(query, :page => page, :per_page => 20)
    end
end
