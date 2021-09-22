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
    has_many :staffs#, :dependent => :delete_all
    has_many :discussion_authorities, :dependent => :delete_all
    has_many :discussions
    has_many :discussion_histories
    has_and_belongs_to_many :groups

    belongs_to :school
    belongs_to :admin, :foreign_key => "join_channel_sales_id"

    mount_uploader :user_img, ImageUploader

    TEMP_EMAIL_PREFIX = 'change@me'
    TEMP_EMAIL_REGEX = /\Achange@me/

    validates_presence_of :email
    validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

    # devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable   # 메일 인증 삭제

    USER_TYPES = {
        "student"           => "학생 (student)",
        "parent"            => "부모님 (parent)",
        "school teacher"    => "학교 선생님 (school teacher)",
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
            else

                if user.confirmed_at.nil?
                    user.user_name = auth.extra.raw_info.name
                    user.confirmed_at = DateTime.now
                    user.save
                end

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
        params.require(:user).permit(:email, :name, :location, :phone, :grade, :coupon_code)
    end

    def can_I_use?
        # 전체 free
        true   # 모두 사용 가능토록 함 (단, main 화면에서 정회원은 Member, 아니면 Free) 124 ~ 132까지 주석처리함

        # level 1 만 볼 수 있도록..결제해야 전체를 볼 수 있음
        # if self.expire_date.nil?
        #     false
        # else
        #     if self.expire_date > Time.new
        #         true
        #     else
        #         false
        #     end
        # end

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

    # 토론방 관리 자격이 있나?
    def can_I_manage_discussion_rooms?
        ret = false

        teacher = Teacher.where('user_id = ? and confirm_yn = ?', self.id, 'Y')

        unless teacher.blank?
            ret = true
        end

        ret
    end

    def am_I_in_this_group?(group_id)
        @groupsUser = GroupsUser.where('group_id = ? and user_id = ?', group_id, self.id)

        unless @groupsUser.blank?
            return true
        else
          return false
        end
    end

end
