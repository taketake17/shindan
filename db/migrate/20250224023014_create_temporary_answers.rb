class CreateTemporaryAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :temporary_answers do |t|
      t.string :session_id, null: false
      t.integer :question_id
      t.integer :selected_value
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index [ "session_id" ], name: "index_temporary_answers_on_session_id"
      t.index [ "question_id" ], name: "index_temporary_answers_on_question_id"
    end
  end
end
