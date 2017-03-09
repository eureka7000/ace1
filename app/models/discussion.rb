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
end