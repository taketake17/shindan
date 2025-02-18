class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.integer :selected_value

      t.timestamps
    end
    add_index :answers, :question_id, unique: true
  end
end
