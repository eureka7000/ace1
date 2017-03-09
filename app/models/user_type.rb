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

end
