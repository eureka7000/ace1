class Discussion < ActiveRecord::Base

    has_many :participants, :dependent => :delete_all
    has_many :discussion_images, :dependent => :delete_all
    has_many :discussion_title_explanations, :dependent => :delete_all
    has_many :discussion_solutions, :dependent => :delete_all
    has_many :discussion_replies, :dependent => :delete_all
    has_many :discussion_histories, :dependent => :delete_all

    belongs_to :user
    belongs_to :unit_concept

    MANAGE_TYPE = {
        'admin' => 'EurekaMath',
        'school manager' => '학교',
        'institute manager' => '학원'
    }

    OVERALL_COLOR_1 = {
        0 => 'pending',
        1 => 'success',
        2 => 'info',
        3 => 'error',
        4 => ''
    }
    OVERALL_COLOR_2 = {
        0 => 'yellow',
        1 => 'green',
        2 => 'blue',
        3 => 'red',
        4 => 'dark'
    }

    def self.get_org_list(school_id)
      query = "select a.id, a.organizer, a.user_id, a.manage_type, a.observer_yn, a.title, a.content, a.answer, a.grade, a.expiration_date, a.interim_report, a.final_report, a.created_at, a.updated_at, a.unit_concept_id, a.concept_explanation, a.level, a.organizer_type, a.think_time, a.like, a.start_date
                from discussions a, users b
                where b.school_id = #{school_id}
                and a.user_id = b.id"
      @discussions = Discussion.find_by_sql(query)

      @discussions
    end
end