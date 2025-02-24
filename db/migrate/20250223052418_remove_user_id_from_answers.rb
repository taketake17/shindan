class RemoveUserIdFromAnswers < ActiveRecord::Migration[8.0]
  def change
    remove_reference :answers, :user, foreign_key: true
  end
end
