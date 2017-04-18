class Discussion < ActiveRecord::Base

    has_many :participants, :dependent => :delete_all
    has_many :discussion_images, :dependent => :delete_all
    has_many :discussion_replies, :dependent => :delete_all
    has_many :discussion_histories, :dependent => :delete_all
    has_many :groups

    belongs_to :user
    belongs_to :discussion_templet

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
      query = "select a.id, a.organizer, a.user_id, a.manage_type, a.observer_yn, a.expiration_date, a.interim_report, a.final_report, a.created_at, a.updated_at, a.organizer_type, a.think_time, a.like, a.start_date, a.sub_leader, a.group_id, a.discussion_templet_id
                from discussions a, users b
                where b.school_id = #{school_id}
                and a.user_id = b.id"
      @discussions = Discussion.find_by_sql(query)

      @discussions
    end

    def self.can_I_join_this_room?(group_id, student_id, observer_yn, user_type)

      if user_type == 'student'
        if observer_yn == 'Y'
          true
        else
          @groups_users = GroupsUser.where('group_id = ? and user_id = ?', group_id, student_id)
          unless @groups_users.blank?
            true
          else
            false
          end
        end
      else
        true
      end

    end

end