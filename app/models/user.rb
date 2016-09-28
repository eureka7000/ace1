class User < ActiveRecord::Base
    
    has_many :user_types, :dependent => :delete_all
    has_many :teachers, :dependent => :delete_all
    has_many :unit_concept_exercise_histories
    has_many :unit_concept_self_evaluations, :dependent => :delete_all
    has_many :user_relations, :dependent => :delete_all
    has_many :questions
    has_many :blogs, :dependent => :delete_all
    has_many :payments
    has_many :study_histories
    has_many :replies
    has_many :identities, :dependent => :delete_all

    belongs_to :school
    belongs_to :admin, :foreign_key => "join_channel_sales_id"

    mount_uploader :user_img, ImageUploader
    
    TEMP_EMAIL_PREFIX = 'change@me'
    TEMP_EMAIL_REGEX = /\Achange@me/
  
    validates_presence_of :email
    validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  
    devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
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
    
    def self.find_for_oauth(auth, signed_in_resource = nil)
        
        # Get the identity and user if they exist
        identity = Identity.find_for_oauth(auth)
        
        # If a signed_in_resource is provided it always overrides the existing user
        # to prevent the identity being locked with accidentally created accounts.
        # Note that this may leave zombie accounts (with no associated identity) which
        # can be cleaned up at a later date.
        user = signed_in_resource ? signed_in_resource : identity.user
        
        # Create the user if needed
        if user.nil?
            
            email = auth.info.email
            user = User.where(:email => email).first if email
            
            # Create the user if it's a new registration
            if user.nil?
                user = User.new(
                    user_name: auth.extra.raw_info.name,
                    email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
                    password: Devise.friendly_token[0,20]
                )
                
                user.skip_confirmation!
                user.save!
                
                # Create User Type.
                user_type = UserType.new
                user_type.user_id = user.id
                user_type.user_type = 'student'
                user_type.save                
                
            end    
        end
        
        # Associate the identity with the user if needed
        if identity.user != user
            identity.user = user
            identity.save!
        end    
        
        user
    end
    
    def email_verified?
        self.email && self.email !~ TEMP_EMAIL_REGEX
    end    
    
    
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
