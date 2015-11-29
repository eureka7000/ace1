class UserType < ActiveRecord::Base

  belongs_to :user

  def user_type_params
      params.require(:user_type).permit(:user_type, :user_id)
  end

end
