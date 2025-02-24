class TemporaryAnswer < ApplicationRecord
    validates :selected_value, presence: true
    validates :question_id, presence: true
    validates :session_id, presence: true


    def self.missing_answers(session_id)
      answered_questions = where(session_id: session_id).pluck(:question_id)
      Question.pluck(:id) - answered_questions
    end

    def self.all_questions_answered?(session_id)
      missing_answers(session_id).empty?
    end

    validate :all_questions_answered, on: :final_submission

    private

    def all_questions_answered
      unless TemporaryAnswer.all_questions_answered?(session_id)
        errors.add(:base, "すべての質問に回答してください")
      end
    end
end
