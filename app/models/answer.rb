class Answer < ApplicationRecord
    validates :question_id, presence: true
    validates :selected_value, presence: true
end
