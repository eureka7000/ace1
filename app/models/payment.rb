class Payment < ActiveRecord::Base
    
    belongs_to :user
    
	CURRENCY_SYMBOLS = {
		"USD" => "$", 
		"KRW" => "&#8361;",
		"JPY" => "&yen",
        "SGD" => "$",
        "HKD" => "$",
        "THB" => "&#3647;",
        "AUD" => "$",
        "GBP" => "&#163;",
        "CHF" => "&#67;",
        "EUR" => "&#8364;"
	}    
    
end
