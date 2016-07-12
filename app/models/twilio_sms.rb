require 'twilio-ruby' 

class TwilioSms
    
    account_sid = 'ACb1ca58b23dbb24089d8059bd2b84400d' 
    auth_token = 'ec3398f92c07aa9cd35d77ae58517890' 
    
    @client = Twilio::REST::Client.new account_sid, auth_token 

    def self.sendSMS(to, body) 
        @client.account.messages.create({
          :from => '+12013800488', 
          :to => to, 
          :body => body, 
        })
    end    
    
end    
 
