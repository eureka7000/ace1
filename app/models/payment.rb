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

	SERVICE_NAME = {
		'1Month' => '1 Month',
		'2Months' => '2 Months',
		'3Months' => '3 Months',
		'4Months' => '4 Months',
		'5Months' => '5 Months',
		'6Months' => '6 Months',
		'month' => 'All Months',
		'교재구입' => 'Textbook'
	}

end
