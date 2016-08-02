class HomesController < ApplicationController

    # before_filter :authenticate_user!

    def index

        unless current_user.nil?
            if current_user.user_types[0].user_type == 'school teacher' || 'mento'
                @questions_number = Question.where('to_user_id = ? and confirm_yn = ?', current_user.id, 'N').count
                @session_yn = 'Y'
            end
        end

        respond_to do |format|
            format.html
        end

    end

end
