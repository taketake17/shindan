class QuestionsController < ApplicationController
  require "kaminari"

  def index
    load_questions
  end

  def new
    load_questions
    load_answers
  end

  def create
    load_questions
    update_temporary_answers
    update_session_answers
    handle_user_action
  end

  def show
    @evaluation = params[:evaluation]
    @total_score = params[:total_score]
    clear_answers
  end

  private

  def load_questions
    @questions = Question.all.page(params[:page]).per(5)
    @answer = Answer.new
  end

  def load_answers
    @answers = TemporaryAnswer.where(session_id: session.id.to_s).pluck(:question_id, :selected_value).to_h
    session[:answers] ||= {}
    session[:answers].merge!(@answers)

    if params[:answers].present?
      permitted_answers = params.require(:answers).permit(Question.pluck(:id).map { |id| [ id.to_s, :selected_value ] }.to_h).to_h
      session[:answers].merge!(permitted_answers)
    end

    @answers = session[:answers]
  end



  def update_temporary_answers
    params[:answers]&.each do |question_id, value|
      TemporaryAnswer.where(session_id: session.id.to_s, question_id: question_id).delete_all
      TemporaryAnswer.create(session_id: session.id.to_s, question_id: question_id, selected_value: value)
    end
  end

  def update_session_answers
    session[:answers] ||= {}
    params[:answers]&.each { |question_id, value| session[:answers][question_id] = value }
  end

  def handle_user_action
    case params[:commit]
    when "結果を見る！" then process_final_submission
    when "次のページへ" then redirect_to new_question_path(page: @questions.next_page)
    when "前のページ" then redirect_to new_question_path(page: @questions.prev_page)
    else render :new
    end
  end

  # app/controllers/questions_controller.rb
  def process_final_submission
    session.delete(:answers)

    missing_question_ids = TemporaryAnswer.missing_answers(session.id.to_s)

    if missing_question_ids.any?
      flash.now[:alert] = "以下の質問に回答してください: #{missing_question_ids.join(', ')}"
      load_questions
      load_answers
      render :new, status: :unprocessable_entity
    else
      process_complete_submission
    end
  end

  def missing_answers
    @questions.select { |q| TemporaryAnswer.where(session_id: session.id.to_s, question_id: q.id).blank? }.map(&:id)
  end

  def process_complete_submission
    answers = TemporaryAnswer.where(session_id: session.id.to_s).pluck(:question_id, :selected_value).to_h
    @total_score = calculate_result(session.id.to_s)
    @evaluation = evaluate_result(@total_score)
    save_answers(answers)
    redirect_to question_result_path(total_score: @total_score, evaluation: @evaluation)
  end

  def save_answers(answers)
    answers.each do |question_id, value|
      TemporaryAnswer.create_or_find_by(session_id: session.id.to_s, question_id: question_id) do |answer|
        answer.selected_value = value
      end
    end
  end

  def calculate_result(session_id)
    TemporaryAnswer.where(session_id: session_id.to_s)
                   .group(:question_id)
                   .sum("CAST(selected_value AS INTEGER)")
                   .values
                   .sum
  end

  def evaluate_result(result)
    case result
    when 100..130 then "あなたは本当に良い人かもしれませんが、謙虚さが足りないようです。本当に良い人は自分から良い人って言わないっておばあちゃんが言ってました。"
    when 30 then "マジで言ってます？良い人狙いに行ってませんか？"
    when 25..29 then "あなたはとても良い人だ！素晴らしいきっと良いことがありますよ！"
    when 18..24 then "あなたは良い人だ！自信持って！"
    when 13..17 then "あなたはまあまあ良い人だ！これくらいの方が人間味があって良いよね"
    when 7..12 then "もっと周りに優しくしてあげても良いかもね"
    when 2..6 then "ちょっと心配になるかも。。。。"
    when 1 then "まさに悪童だ！逃げろ！"
    end
  end

  def clear_answers
    TemporaryAnswer.where(session_id: session.id.to_s).delete_all
    session.delete(:answers)
  end
end
