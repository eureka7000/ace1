class CreateUserTypes < ActiveRecord::Migration
    def change
        create_table :user_types do |t|
            t.integer :user_id
            t.string :use_type
            t.timestamps
        end
    end

end
