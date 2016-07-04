class GradeUnitConcept < ActiveRecord::Base
    
    belongs_to :unit_concept
    validates_presence_of :grade, :chapter, :category, :sub_category, :code, :name, :unit_concept_id
    
    CHAPTERS = {
        110 => '수와 연산',
        120 => '문자와 식',
        130 => '함수',
        140 => '확률과 통계',
        150 => '기하',
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
        480 => '지수와 로그'
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
        48020 => '로그'
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
        4802020 => '상용로그'
    }    
    
end
