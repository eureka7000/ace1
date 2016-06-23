class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :user_types, :dependent => :delete_all
  has_many :teachers, :dependent => :delete_all
  has_many :unit_concept_exercise_histories
  has_many :unit_concept_self_evaluations, :dependent => :delete_all
  has_many :user_relations, :dependent => :delete_all
  has_many :questions

  belongs_to :school
  belongs_to :admin, :foreign_key => "join_channel_sales_id"
  
  validates_presence_of :email
  
  devise :database_authenticatable, :registerable, :confirmable,
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

    USER_STUDY_LEVELS = {
        "1" => "초급",
        "2" => "중급",
        "3" => "상급"
    }
    
    def user_params
        params.require(:user).permit(:email, :name, :location, :phone, :grade)
    end    
                
end
