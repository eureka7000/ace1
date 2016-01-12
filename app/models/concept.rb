class Concept < ActiveRecord::Base
    
    CATEGORIES = {
        "a000" => "총괄",
        "b100" => "집합과 명제",
        "c200" => "수와 식",
        "d300" => "방정식과 부등식",
        "e400" => "함수",
        "f500" => "도형", 
        "g600" => "지수 로그 삼각함수",
        "h700" => "미분과 적분",
        "i800" => "행렬과 벡터",
        "j900" => "확률과 통계"
    }
    
    SUB_CATEGORIES = {
        "a010" => "수학 전반",
        "b110" => "집합",
        "b130" => "명제",
        "c210" => "자연수",
        "c220" => "정수",
        "c230" => "유리수",
        "c240" => "실수",
        "c250" => "복소수",
        "c260" => "유리식",
        "c290" => "무리식",
        "d310" => "일차방정식",
        "d320" => "이차방정식",
        "d330" => "고차방정식",
        "d340" => "연립방정식",
        "d350" => "부정방정식",
        "d360" => "일차부등식",
        "d370" => "이차부등식",
        "d380" => "연립부등식",
        "d390" => "절대부등식, 부등식의 증명",
        "e410" => "함수",
        "e430" => "일차함수",
        "e440" => "이차함수",
        "e460" => "유리함수(분수함수)",
        "e470" => "무리함수",
        "e480" => "삼각함수",
        "f510" => "기본도형",
        "f520" => "삼각형",
        "f530" => "사각형",
        "f540" => "도형의 닮음",
        "f550" => "피타고라스의 정리",
        "f560" => "점과 직선",
        "f570" => "원",
        "f580" => "부등식의 영역",
        "f590" => "입체도형",
        "j910" => "경우의 수",
        "j920" => "확률의 계산",
        "j930" => "자료의 정리",
        "j940" => "자료의 분석"
    }
    
end
