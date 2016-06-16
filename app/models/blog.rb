class Blog < ActiveRecord::Base

  BLOG_TYPES = {
      1 => "학습문제해결",
      2 => "성공사례",
      3 => "수학이야기"
  }
end
