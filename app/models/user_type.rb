class UserType < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :user_id

  def user_type_params
    params.require(:user_type).permit(:user_type, :user_id)
  end

  def is_selected?(admin_id)
    ret = false

    unless self.user.staffs.nil?
      self.user.staffs.each do |staff|
        if staff.admin_id == admin_id
          ret = true
        end
      end
    end

    ret
  end

  def given_authority?(admin_id)
    ret = false

    unless self.user.discussion_authorities.nil?
      self.user.discussion_authorities.each do |authority|
        if authority.admin_id == admin_id
          ret = true
        end
      end
    end

    ret
  end

  def self.get_my_authority_member(school_id)
    query = "select a.id, a.user_id, a.user_type, a.created_at, a.updated_at
                from user_types a, users b
                where b.school_id = #{school_id}
                and a.user_id = b.id"
    @institute_teachers = UserType.find_by_sql(query)

    @institute_teachers
  end

end
