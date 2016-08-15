class Blog < ActiveRecord::Base
    
    belongs_to :user

    mount_uploader :file_name, ImageUploader
    
    validates_presence_of :blog_type, :title, :content, :user_id

  BLOG_TYPES = {
    "1" => "학습문제해결",
    "2" => "성공사례",
    "3" => "수학이야기",
    "4" => "FAQ",
    "5" => "공지사항",
    "6" => "새소식",
    "7" => "회사소개"
  }

  BLOG_NAMES = {
    "1" => "learning_problem_solution",
    "2" => "succession_case",
    "3" => "math_story",
    "4" => "faq",
    "5" => "notice",
    "6" => "the_news",
    "7" => "company_introduction"
  }
  
end
