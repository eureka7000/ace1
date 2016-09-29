class Concept < ActiveRecord::Base
    
    has_many :unit_concepts
    has_many :concept_exercises
    has_many :grade_unit_concepts
    
    validates_presence_of :category, :sub_category, :concept_name, :exercise_yn
    
    CATEGORIES = {
        "c000" => "총괄",
        "c100" => "집합과 명제",
        "c200" => "수와 식",
        "c300" => "방정식과 부등식",
        "c400" => "함수",
        "c500" => "도형", 
        "c600" => "지수 로그 삼각함수 수열",
        "c700" => "미분과 적분",
        "c800" => "기하과 벡터",
        "c900" => "확률과 통계"
    }
    
    FA_ICONS = [
        "fa-car", "fa-bomb", "fa-child", "fa-cube", "fa-deviantart", "fa-envelope-square", "fa-openid", "fa-paw",
        "fa-qq", "fa-reddit", "fa-share-alt", "fa-soundcloud", "fa-steam", "fa-wordpress", "fa-building", "fa-circle-o-notch"
    ]
    
    ICONS_BGS = [
        "icon-bg-u", "icon-bg-blue", "icon-bg-red", "icon-bg-sea", "icon-bg-green", "icon-bg-yellow", "icon-bg-orange", "icon-bg-grey",
        "icon-bg-dark", "icon-bg-darker", "icon-bg-purple", "icon-bg-aqua", "icon-bg-brown", "icon-bg-dark-blue", "icon-bg-light-green", "icon-bg-light"
    ]    
    
    SUB_CATEGORIES = {
        "c010" => "수학 전반",
        "c110" => "집합",
        "c130" => "명제",
        "c210" => "자연수",
        "c220" => "정수",
        "c230" => "유리수",
        "c240" => "실수",
        "c250" => "복소수",
        "c260" => "다항식(1)",
        "c270" => "다항식(2)",
        "c280" => "분수식",
        "c290" => "무리식",
        "c310" => "일차방정식",
        "c320" => "이차방정식",
        "c330" => "고차방정식",
        "c340" => "연립방정식",
        "c350" => "여러가지 방정식",
        "c360" => "일차부등식",
        "c370" => "이차부등식",
        "c380" => "연립부등식",
        "c390" => "절대부등식",
        "c410" => "함수",
        "c430" => "일차함수",
        "c440" => "이차함수",
        "c460" => "분수함수",
        "c470" => "무리함수",
        "c480" => "삼각함수",
        "c510" => "기본도형",
        "c520" => "삼각형",
        "c530" => "사각형",
        "c540" => "도형의 닮음",
        "c550" => "피타고라스의 정리",
        "c560" => "점과 직선",
        "c570" => "원",
        "c580" => "부등식의 영역",
        "c590" => "입체도형",
        "c610" => "지수함수",
        "c630" => "로그함수",
        "c650" => "삼각함수",
        "c670" => "수열",
        "c710" => "수열의 극한",
        "c720" => "함수의 극한과 연속",
        "c730" => "다항함수의 미분법",
        "c740" => "다항함수의 미분법의 활용",
        "c750" => "여러 가지 함수의 미분법",
        "c760" => "여러 가지 함수의 미분법의 활용",
        "c770" => "다항함수의 적분법",
        "c780" => "다항함수의 적분법의 활용",
        "c790" => "여러 가지 함수의 적분법",
        "c810" => "평면곡선",
        "c820" => "평면벡터",
        "c830" => "평면벡터의 활용",
        "c840" => "공간도형",
        "c850" => "공간좌표",
        "c860" => "공간벡터",
        "c910" => "경우의 수",
        "c920" => "순열",
        "c930" => "조합",
        "c940" => "확률",
        "c950" => "자료의 정리",
        "c960" => "자료의 분석",
        "c970" => "확률변수와 확률분포",
        "c980" => "통계적 추정"
    }
    
    DESC_TYPES = {
        1 => "Concept",
        2 => "Explanation",
        3 => "Solution",
        4 => "Video",
        5 => "link",
        7 => "Answer"
    }
    
    PAST_TEST_ORGS = {
        "AAT"  => "수능",
        "EO"   => "교육청",
        "KICE" => "평가원",
        "MT"   => "모의고사"
    }

    def get_level_star

        ret = ""

        unless self.level.nil?

            ret += "<span class='item-box'><span class='item'>"

            rst = 5 - self.level

            (1..self.level).each do |idx|
                ret += " <i class='fa fa-star'></i> "
            end

            (1..rst).each do |idx|
                ret += " <i class='fa fa-star-o'></i> "
            end

            ret += "</span></span>"
        end

        ret

    end

end
