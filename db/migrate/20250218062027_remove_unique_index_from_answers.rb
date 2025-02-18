class RemoveUniqueIndexFromAnswers < ActiveRecord::Migration[7.2]
  def change
    remove_index :answers, :question_id
    add_index :answers, :question_id
  end
end
