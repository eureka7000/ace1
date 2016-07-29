class AddConfirmToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :confirm_yn, :string
  end
end
