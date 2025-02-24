namespace :cleanup do
    desc "Remove duplicate TemporaryAnswers, keeping only the latest for each session and question"
    task remove_duplicate_temporary_answers: :environment do
      TemporaryAnswer.select("DISTINCT ON (session_id, question_id) *")
                     .order("session_id, question_id, updated_at DESC")
                     .each do |latest_answer|
        TemporaryAnswer.where(session_id: latest_answer.session_id, question_id: latest_answer.question_id)
                       .where.not(id: latest_answer.id)
                       .delete_all
      end
      puts "Duplicate TemporaryAnswers have been removed."
    end
  end
