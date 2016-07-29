require 'digest'

class InicisPayment < ActiveRecord::Base
    
    GO_PAY_METHOD = {
        'Card' => '신용카드',
        'DirectBank' => '실시간계좌이체',
        'HPP' => '핸드폰',
        'OCBPoint' => 'OK Cashbag 포인트',
        'Vbank' => '무통장입금(가상계좌)',
        'PhoneBill' => '폰빌, 전화결제',
        'Culture' => '문화상품권결제',
        'DGCL' => '스마트문상 결제',
        'TeenCash' => '틴캐시',
        'Bcsh' => '도서문화상품권',
        'HPMN' => '해피머니상품권',
        'YPAY' => '엘로페이',
        'Kpay' => '케이페이',
        'Paypin' => '페이핀',
        'EasyPay' => '간편결제',
        'EWallet' => '전자지갑',
        'POINT' => '포인트',
        'GiftCard' => '상품권'
    }
    
    CARD_CODE = {
        '01' => '하나',
        '03' => '롯데',
        '04' => '현대',
        '06' => '국민',
        '11' => 'BC',
        '12' => '삼성',
        '14' => '신한',
        '15' => '한미',
        '16' => 'NH',
        '17' => '하나카드',
        '21' => '해외비자',
        '22' => '해외마스터',
        '23' => 'JCB',
        '24' => '해외아멕스',
        '25' => '해외다이너스'
    }
    
    def self.getTimestamp
		
		# # timezone 을 설정하지 않으면 getTimestamp() 실행시 오류가 발생한다.
		# php.ini 에 timezone 설정이 되어 잇으면 아래 코드가 필요없다. 
		# php 5.3 이후로는 반드시 timezone 설정을 해야하기 때문에 아래 코드가 필요없을 수 있음. 나중에 확인 후 수정필요.
		# 이니시스 플로우에서 timestamp 값이 중요하게 사용되는 것으로 보이기 때문에 정확한 timezone 설정후 timestamp 값이 필요하지 않을까 함.
        # date_default_timezone_set('Asia/Seoul');
        # $date = new DateTime();
        #
        # $milliseconds = round(microtime(true) * 1000);
        # $tempValue1 = round($milliseconds/1000);        //max integer 자릿수가 9이므로 뒤 3자리를 뺀다
        # $tempValue2 = round(microtime(false) * 1000);    //뒤 3자리를 저장
        # switch (strlen($tempValue2)) {
        #     case '3':
        #         break;
        #     case '2':
        #         $tempValue2 = "0".$tempValue2;
        #         break;
        #     case '1':
        #         $tempValue2 = "00".$tempValue2;
        #         break;
        #     default:
        #         $tempValue2 = "000";
        #         break;
        # }
        #
        # return "".$tempValue1.$tempValue2;
              
    end    
    
	 #*** 위변조 방지체크를 signature 생성 ***

	 #mid, price, timestamp 3개의 키와 값을	
	 #key=value 형식으로 하여 '&'로 연결한 하여 SHA-256 Hash로 생성 된값	
	 #ex) mid=INIpayTest&price=819000&timestamp=2012-02-01 09:19:04.004

	 #* key기준 알파벳 정렬
	 #* timestamp는 반드시 signature생성에 사용한 timestamp 값을 timestamp input에 그대로 사용하여야함
	 #*/	
    def self.make_signature(sign_param)

        # ksort($signParam);
        # $string = "";
        # foreach ($signParam as $key => $value) {
        #     $string .= "&$key=$value";
        # }
        # $string = substr($string, 1); // remove leading "&"
        #
        # $sign = $this->makeHash($string, "sha256");
        #
        # return $sign;
    
    end

    def self.make_hash(data)
        Digest::SHA256.hexdigest data
    end        

end
