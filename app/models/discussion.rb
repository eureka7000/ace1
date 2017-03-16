class Discussion < ActiveRecord::Base
    has_many :users
    has_many :participants, :dependent => :delete_all
    has_many :discussion_images, :dependent => :delete_all
    # has_many :unit_concepts

    MANAGE_TYPE = {
        'admin' => 'EurekaMath',
        'school manager' => '학교',
        'institute manager' => '학원'
    }

    def self.get_org_list(school_id)
      query = "select a.id, a.organizer, a.leader, a.manage_type, a.observer_yn, a.title, a.content, a.title_explanation, a.answer, a.grade, a.expiration_date, a.interim_report, a.final_report, a.created_at, a.updated_at, a.unit_concept_id, a.solution, a.concept_explanation, a.level, a.organizer_type
                from discussions a, users b
                where b.school_id = #{school_id}
                and a.leader = b.id"
      @discussions = Discussion.find_by_sql(query)

      @discussions
    end
end