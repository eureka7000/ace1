class RegistrationsController < Devise::RegistrationsController
    
    def new
        @page_name = t(:sign_up)
        super
    end

    
    def create
        puts '---------bigin'
        logger.debug '******************--------super-bigin'

        super
        @user.skip_confirmation!    # 'mypage에서 인증메일 발송하였습니다. 2일이내에 인증바람'라는 모달 안뜸

        puts '---------super-end'
    
        coupon_code = params[:user][:coupon_code]
        user = User.find(current_user.id)    
        puts '---------1'
        puts user
        puts user.inspect
    
        # Coupon 적용.
        if coupon_code.blank?
            user.user_auth = 'free'
        else
            coupons = Coupon.where('coupon_code = ? and expire_from <= ? and expire_to > ?', coupon_code, Time.now(), Time.now())
        
            if coupons.size > 0
            
                coupon = coupons.first
                effective_period_type = coupon.effective_period_type
                effective_period = coupon.effective_period
                
                if effective_period_type == 'day'
                    user.expire_date = effective_period.days.from_now
                elsif effective_period_type == 'month'
                    user.expire_date = effective_period.months.from_now
                elsif effective_period_type == 'year'
                    user.expire_date = effective_period.years.from_now
                elsif effective_period_type == 'forever'            
                    user.expire_date = 10.years.from_now
                end
                
                user.user_auth = 'member'
            else    
                user.user_auth = 'free'
            end
            
        end
        user.skip_confirmation!
        user.save
        
        user_type = UserType.new
        user_type.user_id = @user.id
        user_type.user_type = params[:user_type][:user_type]
        user_type.save

    end
    
    
    def update
        super
    end
  
    def sign_up_params
        params.require(:user).permit(:email, :name, :location, :phone, :grade, :coupon_code, :password, :password_confirmation)
    end
  
end 