class School < ActiveRecord::Base
    
    has_many :admins
    has_many :teachers
    has_many :users
    
    validates :name, :presence => {:message => "학교명은 필수 입력항목입니다."}
    validates :grade, :presence => {:message => "등급은 필수 입력항목입니다."}
    validates :is_school, :presence => {:message => "학교학원 구분은 필수 입력항목입니다."}
    
    SCHOOL_GEADES = {
        "primary" => "초등",
        "middle"  => "중등",
        "high"    => "고등",
        "all" => "전체"
    }    
    
end
