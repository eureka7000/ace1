class CreateExplanations < ActiveRecord::Migration
  def change
    create_table :explanations do |t|
      t.string :code

      t.timestamps null: false
    end
  end
end
