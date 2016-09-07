class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :user_types, :dependent => :delete_all
  has_many :teachers, :dependent => :delete_all
  has_many :unit_concept_exercise_histories
  has_many :unit_concept_self_evaluations, :dependent => :delete_all
  has_many :user_relations, :dependent => :delete_all
  has_many :questions
  has_many :blogs, :dependent => :delete_all
  has_many :payments
  has_many :study_histories

  belongs_to :school
  belongs_to :admin, :foreign_key => "join_channel_sales_id"

  mount_uploader :user_img, ImageUploader
  
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
    
    USER_AUTHS = {
        "free" => "Free",
        "paid" => "결제완료"
    }
    
    def user_params
        params.require(:user).permit(:email, :name, :location, :phone, :grade)
    end
    
    def can_I_use?
        if self.expire_date.nil?
            false
        else
            if self.expire_date > Time.new
                true
            else
                false
            end        
        end        
    end
    
    def get_expire_date(month)
        
        expire_date = Time.new
    
        if self.expire_date.nil?
            expire_date = expire_date + month.months  
        else
            if self.expire_date < expire_date
                expire_date = expire_date + month.months
            else
                expire_date = self.expire_date + month.months
            end                    
        end
    end

end
