class Teacher < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :school

    def self.get_students
        # 코드 수정
    end

end
