class Question < ApplicationRecord
    validates :question1, presence: true
    validates :question2, presence: true
    validates :question3, presence: true
    validates :question4, presence: true
end
