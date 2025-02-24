class AddQuestions < ActiveRecord::Migration[8.0]
  def change
    change_table :questions do |t|
      t.remove :question1
      t.remove :question2
      t.remove :question3
      t.remove :question4
      t.string :text
      t.string :option1
      t.string :option2
      t.string :option3
      t.string :value1
      t.string :value2
      t.string :value3
    end
  end
end
