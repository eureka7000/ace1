class GradeUnitConcept < ActiveRecord::Base
    
    # belongs_to :unit_concept
    belongs_to :concept
    
    validates_presence_of :grade, :chapter, :category, :sub_category, :code, :name, :concept_id
    
    CHAPTERS = {
        110 => '수와 연산',
        120 => '문자와 식',
        130 => '함수',
        140 => '확률과 통계',
        150 => '도형',
        210 => '수와 연산',
        220 => '문자와 식',
        230 => '함수',
        240 => '확률과 통계',
        250 => '기하',
        310 => '수와 연산',
        320 => '문자와 식',
        330 => '함수',
        340 => '확률과 통계',
        350 => '기하',        
        410 => '수',
        420 => '다항식',
        430 => '방정식과 부등식',
        440 => '도형의 방정식',
        450 => '집합과 명제',
        460 => '함수',
        470 => '수열',
        480 => '지수와 로그',
				510 => '미분과 적분',
				520 => '확률과 통계',
				610 => '지수 로그 삼각함수',
				620 => '미분과 적분',
				630 => '기하와 벡터'
    }
    
    CATEGORIES = {
        11010 => '약수와 배수',
        11020 => '정수와 유리수',
        12010 => '문자와 식',
        12020 => '일차방정식',
        13010 => '함수와 그래프',
        14010 => '통계',
        15010 => '기본도형',
        15020 => '작도와 합동',
        15030 => '평면도형의 성질',
        15040 => '입체도형의 성질',
        21010 => '유리수와 순환소수',
        22010 => '식의 계산',
        22020 => '연립방정식',
        22030 => '부등식',
        23010 => '일차함수',
        24010 => '확률',
        25010 => '삼각형의 성질',
        25020 => '사각형의 성질',
        25030 => '도형의 닮음',
        25040 => '닮음의 활용',
        31010 => '실수',
        32010 => '다항식의 인수분해',
        32020 => '이차방정식',
        33010 => '이차함수',
        34010 => '대푯값과 산포도',
        35010 => '피타고라스의 정리',
        35020 => '삼각비',
        35030 => '원의 성질',
        41010 => '수학 전반',
        41020 => '정수',
        41030 => '실수',
        42010 => '다항식',
        42020 => '인수분해',
        43010 => '일차방정식',
        43020 => '복소수와 이차방정식',
        43030 => '이차방정식과 이차함수',
        43040 => '여러가지 방정식',
        43050 => '여러가지 부등식',
        44010 => '평면좌표',
        44020 => '직선의 방정식',
        44030 => '원의 방정식',
        44040 => '도형의 이동',
        44050 => '부등식의 영역',
        45010 => '집합',
        45020 => '명제',
        46010 => '함수',
        46020 => '유리함수와 무리함수',
        47010 => '수열',
        48010 => '지수',
        48020 => '로그',
				51010 => '수열의 극한',
				51020 => '함수의 극한과 연속',
				51030 => '다항함수의 미분법',
				51040 => '다항함수의 미분법의 활용',
				51050 => '다항함수의 적분법',
				51060 => '다항함수의 적분법의 활용',
				52010 => '경우의 수',
				52020 => '조합',
				52030 => '확률',
				52040 => '확률변수와 확률분포',
				52050 => '통계적 추정',
				61010 => '지수함수',
				61020 => '로그함수',
				61030 => '삼각함수',
				62010 => '함수의 극한과 연속',
				62020 => '여러 가지 함수의 미분법',
				62030 => '여러 가지 함수의 미분법의 활용',
				62040 => '여러 가지 함수의 적분법',
				63010 => '평면곡선',
				63020 => '평면벡터',
				63030 => '평면벡터의 활용',
				63040 => '공간도형',
				63050 => '공간좌표',
				63060 => '공간벡터'
    }
    
    MAPPING_EXERCISE = {
    	'11010' => ["c210"],
    	'11020' => ["c220", "c230"],
    	'12010' => ["c260"],
    	'12020' => ["c310"],
    	'13010' => ["c410"],
    	'14010' => ["c950"],
    	'15010' => ["c510"],
    	'15020' => ["c510", "c520"],
    	'15030' => ["c530", "c570"],
    	'15040' => ["c590"],
    	'21010' => ["c230"],
    	'22010' => ["c260"],
    	'22020' => ["c340"],
    	'22030' => ["c360", "c380"],
    	'23010' => ["c430"],
    	'24010' => ["c910"],
    	'25010' => ["c520"],
    	'25020' => ["c530"],
    	'25030' => [],
    	'25040' => ["c540"],
    	'31010' => ["c240"],
    	'32010' => ["c270"],
    	'32020' => ["c320"],
    	'33010' => ["c440"],
    	'34010' => ["c960"],
    	'35010' => ["c550"],
    	'35020' => ["c480"],
    	'35030' => ["c570"],
    	'41010' => ["c100", "c010"],
    	'41020' => ["c220"],
    	'41030' => ["c240"],
    	'42010' => [],
    	'42020' => ["c270"],
    	'43010' => ["c310"],
    	'43020' => ["c250"],
    	'43030' => ["c320"],
    	'43040' => ["c330", "c350"],
    	'43050' => ["c360", "c370", "c380"],
    	'44010' => [],
    	'44020' => ["c560"],
    	'44040' => ["c410"],
    	'44050' => ["c580"],
    	'45010' => ["c110"],
    	'45020' => ["c130", "c390"],
    	'46010' => ["c410"],
    	'46020' => ["c280", "c290", "c460", "c470"],
    	'47010' => ["c670"],
    	'48010' => ["c610"],
    	'48020' => ["c630"],
			'51010' => ["c710"],
			'51020' => ["c720"],
			'51030' => ["c730"],
			'51040' => ["c740"],
			'51050' => ["c770"],
			'51060' => ["c780"],
			'52010' => ["c910, c920"],
			'52020' => ["c930"],
			'52030' => ["c940"],
			'52040' => ["c970"],
			'52050' => ["c980"],
			'61010' => ["c610"],
			'61020' => ["c630"],
			'61030' => ["c650, c660"],
			'62010' => ["c720"],
			'62020' => ["c750"],
			'62030' => ["c760"],
			'62040' => ["c790"],
			'63010' => ["c810"],
			'63020' => ["c820"],
			'63030' => ["c830"],
			'63040' => ["c840"],
			'63050' => ["c850"],
			'63060' => ["c860"]
		}
   
    
    SUB_CATEGORIES = {
        1101010 => '소인수분해',
        1101020 => '최대공약수와 최소공배수',
        1102010 => '정수와 유리수',
        1102020 => '정수와 유리수의 사칙계산',
        1201010 => '문자의 사용',
        1201020 => '일차식의 계산',
        1202010 => '방정식과 그 해',
        1202020 => '일차방정식의 풀이',
        1202030 => '일차방정식의 활용',
        1301010 => '함수의 뜻과 표현',
        1301020 => '순서쌍과 좌표',
        1301030 => '함수의 그래프',
        1401010 => '도수분포와 그래프',
        1401020 => '상대도수의 분포',
        1501010 => '점,선,면,각',
        1501020 => '위치 관계',
        1501030 => '평행선의 성질',
        1502010 => '삼각형의 작도',
        1502020 => '삼각형의 합동',
        1503010 => '다각형의 성질',
        1503020 => '원과 부채꼴',
        1504010 => '다면체와 회전체의 성질',
        1504020 => '입체도형의 겉넓이와 부피',
        2101010 => '순환소수',
        2101020 => '유리수와 순환소수의 관계',
        2201010 => '다항식의 계산',
        2201020 => '곱셈 공식과 등식의 변형',
        2202010 => '미지수가 2개인 연립일차방정식',
        2202020 => '연립일차방정식의 풀이',
        2202030 => '연립일차방정식의 활용',
        2203010 => '부등식과 그 해',
        2203020 => '일차부등식',
        2203030 => '일차부등식의 활용',
        2203040 => '연립일차부등식',
        2203050 => '연립일차부등식의 활용',
        2301010 => '일차함수와 그래프',
        2301020 => '일차함수식을 구하는 방법',
        2301030 => '일차함수식의 활용',
        2301040 => '일차함수식와 일차방정식',
        2401010 => '경우의 수',
        2401020 => '확률',
        2501010 => '이등변 삼각형',
        2501020 => '직각삼각형의 합동조건',
        2501030 => '삼각형의 내심',
        2501040 => '삼각형의 외심',
        2501050 => '삼각형의 무게중심',
        2502010 => '사다리꼴',
        2502020 => '평행사변형',
        2502030 => '여러 가지 사각형',
        2503010 => '닮은 도형',
        2503020 => '삼각형의 닮음',
        2504010 => '평행선과 선분의 길이의 비',
        2504020 => '삼각형의 각의 이등분선',
        2504030 => '삼각형의 중점연결정리',
        2504040 => '닮음의 활용',
        3101010 => '제곱근과 실수',
        3101020 => '근호를 포함한 식의 계산',
        3201010 => '인수분해',
        3201020 => '여러 가지 인수분해',
        3202010 => '이차방정식',
        3202020 => '이차방정식의 풀이',
        3202030 => '이차방정식의 활용',
        3301010 => '이차함수와 그래프',
        3301020 => '이차함수의 최대값과 최소값',
        3301030 => '이차함수의 활용',
        3401010 => '대표값',
        3401020 => '산포도',
        3501010 => '피타고라스의 정리',
        3501020 => '피타고라스의 정리의 활용',
        3502010 => '삼각비',
        3502020 => '삼각비의 활용',
        3503010 => '원과 직선',
        3503020 => '원주각',
        4101010 => '수학의 정의',
        4101020 => '식과 그래프',
        4101030 => '수학 전반에 걸친 기본개념',
        4101040 => '수학 공부를 잘할 수 있는 방법',
        4102010 => '정수의 분류',
        4102020 => '약수와 배수',
        4102030 => '최대 공약수와 유클리드 호제법',
        4102040 => '기타 정수 이야기',
        4103010 => '무리수의 상등관계',
        4103020 => '무리수의 규칙성',
        4103030 => '절대값의 성질',
        4103040 => '가우스 함수',
        4103050 => '기수법',
        4201010 => '다항식의 연산',
        4201020 => '나머지 정리',
        4202010 => '인수분해',
        4301010 => '일차방정식',
        4301020 => '공통근과 부정방정식',
        4302010 => '복소수의 뜻과 사칙계산',
        4302020 => '이차방정식의 판별식',
        4303010 => '이차함수와 이차방정식의 관계',
        4303020 => '이차함수의 최대, 최소',
        4304010 => '삼차방정식과 사차방정식',
        4304020 => '연립방정식',
        4304030 => '공통근과 부정방정식',
        4305010 => '절대값을 포함한 일차부등식',
        4305020 => '이차부등식과 연립이차부등식',
        4401010 => '두 점 사이의 거리',
        4401020 => '선분의 내분점과 외분점',
        4402010 => '직선의 방정식',
        4402020 => '두 직선의 평행과 수직',
        4402030 => '점과 직선 사이의 거리',
        4402040 => '삼각형의 수심과 방심',
        4402050 => '자취방정식',
        4403010 => '원의 방정식',
        4403020 => '원과 직선의 위치 관계',
        4404010 => '평행이동',
        4404020 => '대칭이동',
        4405010 => '부등식의 영역',
        4405020 => '부등식의 영역에서 최대, 최소',
        4501010 => '집합의 뜻과 표현',
        4501020 => '집합 사이의 포함 관계',
        4501030 => '집합의 연산과 연산 법칙',
        4501040 => '유한집합의 요소의 개수',
        4502010 => '명제와 조건',
        4502020 => '명제의 역과 대우',
        4502030 => '필요조검과 충분조건',
        4502040 => '절대부등식의 증명',
        4601010 => '함수의 뜻과 그래프',
        4601020 => '합성함수',
        4601030 => '역함수',
        4602010 => '유리식과 유리함수',
        4602020 => '무리식과 무리함수',
        4701010 => '등차수열',
        4701020 => '등비수열',
        4701030 => '시그마의 성질과 용법',
        4701040 => '계차수열',
        4701050 => '여러 가지 수열',
        4701060 => '수학적 귀납법',
        4801010 => '거듭제곱근',
        4801020 => '지수법칙',
        4802010 => '로그',
        4802020 => '상용로그',
				5101010 => '수열의 수렴, 발산',
				5101020 => '등비수열의 수렴과 발산',
				5101030 => '급수',
				5101040 => '등비급수',
				5102010 => '함수의 수렴, 발산',
				5102020 => '극한값의 계산',
				5102030 => '미정계수의 결정',
				5102040 => '함수의 연속',
				5103010 => '미분계수',
				5103020 => '미분가능성과 연속성',
				5103030 => '도함수와 미분법',
				5103040 => '접선의 방정식',
				5103050 => '평균값 정리',
				5103060 => '함수의 증가와 감소',
				5103070 => '함수의 극대와 극소',
				5103080 => '함수의 그래프 개형',
				5103090 => '함수가 극값을 가질 조건',
				5104010 => '함수의 최댓값과 최솟값',
				5104020 => '방정식에의 활용',
				5104030 => '부등식에의 활용',
				5104040 => '속도와 가속도',
				5104050 => '시각에 대한 길이, 넓이, 부피의 변화율',
				5105010 => '부정적분',
				5105020 => '다항함수의 부정적분',
				5105030 => '구분구적법',
				5105040 => '정적분',
				5105050 => '정적분의 계산',
				5105060 => '정적분으로 정의된 함수의 미분과 극한',
				5105070 => '정적분과 급수',
				5106010 => '곡선과 좌표축 사이의 넓이',
				5106020 => '두 곡선 사이의 넓이',
				5106030 => '넓이의 활용',
				5106040 => '속도와 거리',
				5201010 => '경우의 수',
				5201020 => '순열',
				5201030 => '여러 가지 순열',
				5202010 => '조합',
				5202020 => '중복조합',
				5202030 => '조합과 분할, 분배',
				5202040 => '이항정리',
				5202050 => '이항정리의 활용',
				5203010 => '확률',
				5203020 => '조건부 확률',
				5203030 => '독립시행의 확률',
				5204010 => '확률변수와 확률분포',
				5204020 => '이산확률변수와 확률분포',
				5204030 => '이항분포',
				5204040 => '연속확률변수의 확률밀도함수',
				5204050 => '정규분포',
				5204060 => '이항분포와 정규분호의 관계',
				5205010 => '표본평균의 분포',
				5205020 => '모평균의 추정',
				5205030 => '표본비율의 분포',
				5205040 => '모비율의 추정',
				6101010 => '지수함수와 그래프',
				6101020 => '지수를 포함한 방정식',
				6101030 => '지수를 포함한 부등식',
				6102010 => '로그함수와 그래프',
				6102020 => '로그를 포함한 방정식',
				6102030 => '로그를 포함한 부등식',
				6103011 => '일반각과 호도법',
				6103012 => '삼각함수',
				6103013 => '삼각함수의 상호 관계',
				6103014 => '삼각함수의 각의 변환',
				6103015 => 'sinx의 그래프',
				6103016 => 'cosx의 그래프',
				6103017 => 'tanx의 그래프',
				6103018 => '여러 가지 모양의 삼각함수의 그래프',
				6103019 => '삼각함수의 최대, 최소',
				6103020 => '삼각함수를 포함한 방정식',
				6103021 => '삼각함수를 포함한 부등식',
				6103022 => '삼각함수의 덧셈정리',
				6103023 => '삼각함수의 합성',
				6201010 => '지수, 로그함수의 극한',
				6201020 => '삼각함수의 극한',
				6202010 => '지수함수와 로그함수의 미분법',
				6202020 => '삼각함수의 미분법',
				6202030 => '함수의 몫의 미분법',
				6202040 => '여러 가지 미분법',
				6202050 => '이계도함수',
				6202060 => '접선의 방정식',
				6202070 => '함수의 극대와 극소',
				6202080 => '곡선의 오목과 볼록',
				6202090 => '함수의 그래프 개형',
				6203010 => '함수의 최댓값과 최솟값',
				6203020 => '방정식에의 활용',
				6203030 => '부등식에의 활용',
				6204010 => '여러 가지 함수의 부정적분',
				6204020 => '치환적분법',
				6204030 => '부분적분법',
				6204040 => '정적분의 정의와 기본 성질',
				6204050 => '정적분의 치환적분법과 부분적분법',
				6204060 => '넓이',
				6204070 => '입체도형의 부피',
				6301010 => '포물선',
				6301020 => '타원',
				6301030 => '쌍곡선',
				6301040 => '음함수의 미분법과 접선의 방정식',
				6301050 => '매개변수로 나타낸 함수의 비분법과 접선의 방정식',
				6302010 => '벡터',
				6302020 => '벡터의 뎃셈과 뺄셈',
				6302030 => '벡터의 실수배',
				6302040 => '위치벡터',
				6302050 => '평면벡터의 성분',
				6302060 => '평면벡터의 내적',
				6302070 => '직선의 벡터방정식',
				6302080 => '평면벡터를 이용한 원의 방정식',
				6303010 => '속도와 가속도',
				6303020 => '속도와 거리',
				6304010 => '평면의 결정조건',
				6304020 => '직선과 평면의 위치관계',
				6304030 => '직선과 평면의 평행과 수직',
				6304040 => '삼수선의 정리',
				6304050 => '두 평면이 이루는 각의 크기',
				6304060 => '정사영',
				6304070 => '전개도',
				6305010 => '공간에서의 두 점 사이의 거리',
				6305020 => '공간에서의 선분의 내분점 외분점',
				6305030 => '구의 방정식',
				6305040 => '구와 평면의 교선의 방정식',
				6306010 => '공간벡터',
				6306020 => '공간벡터의 성분',
				6306030 => '공간벡터의 내적',
				6306040 => '직선의 방정식',
				6306050 => '평면의 방정식',
				6306060 => '점과 평면 사이의 거리',
				6306070 => '구의 방정식'
    }    
    
end
