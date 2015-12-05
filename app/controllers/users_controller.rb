class UsersController < ApplicationController

    before_filter :authenticate_user!

    def welcome

        respond_to do |format|
            format.html
        end

    end

end