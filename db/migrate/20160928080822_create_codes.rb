class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :category
      t.string :code_name
      t.string :use_yn, :default => 'Y'

      t.timestamps null: false
    end
  end
end
