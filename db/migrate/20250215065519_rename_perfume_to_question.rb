class RenamePerfumeToQuestion < ActiveRecord::Migration[7.2]
  def change
    rename_table :perfumes, :questions
  end
end
