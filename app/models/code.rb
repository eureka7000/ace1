class Code < ActiveRecord::Base
    
    validates_presence_of :category, :code_name
    
	CODE_CATEGORIES = {
		"past_test_questions" => "기출문제" 
	}   
    
end
