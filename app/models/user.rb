class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
    USER_TYPES = {
        "student"           => "학생",
        "parent"            => "부모",
        "school teacher"    => "학교 선생님",
        "institute teacher" => "학원 선생님",
        "school manager"    => "학교 관리자",
        "institute manager" => "학원 관리자", 
        "mento"             => "멘토"
    }            
end
