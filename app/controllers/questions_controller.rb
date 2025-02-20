class QuestionsController < ApplicationController
    require "kaminari"

    def index
      load_questions
    end

    def new
      load_questions
      @answers = session[:answers] || {}
    end

    def create
      load_questions
      update_session_answers
      @answers = params[:answers].present? ? params[:answers]: {}

      case params[:commit]
      when "結果を見る！"
        process_final_submission
      when "次のページへ"
        redirect_to new_question_path(page: @questions.next_page)
      when "前のページ"
        redirect_to new_question_path(page: @questions.prev_page)
      else
        render :new
      end
    end

    def show
      @evaluation = params[:evaluation]
      @total_score = params[:total_score]
    end

    private

    def load_questions
      @questions = YAML.load_file(Rails.root.join("app", "data", "questions.yml"))["questions"]
      @questions = Kaminari.paginate_array(@questions).page(params[:page]).per(5)
    end

    def update_session_answers
      session[:answers] ||= {}
      params[:answers]&.each do |question_id, answer|
        session[:answers][question_id] = answer
      end
    end

    def process_final_submission
        all_questions = YAML.load_file(Rails.root.join("app", "data", "questions.yml"))["questions"]
        missing_answers = all_questions.select { |q| session[:answers][q["id"].to_s].blank? }
                                       .map { |q|q["id"] }

        if missing_answers.any?
          flash.now[:alert] = "以下の質問に回答してください: #{missing_answers.join(', ')}"
          render :new, status: :unprocessable_entity
        else
          @total_score = calculate_result(session[:answers])
          @evaluation = evaluate_result(@total_score)
          save_answers(session[:answers])
          session.delete(:answers)
          redirect_to question_result_path(total_score: @total_score, evaluation: @evaluation)
        end
    end


    def save_answers(answers)
      answers.each do |question_id, value|
        Answer.create(question_id: question_id, selected_value: value)
      end
    end

    def calculate_result(answers)
      answers.values.map(&:to_i).sum
    end

    def evaluate_result(result)
      case result
      when 100..130
        "あなたは本当に良い人かもしれませんが、謙虚さが足りないようです。本当に良い人は自分から良い人って言わないっておばあちゃんが言ってました。"
      when 30
        "マジで言ってます？良い人狙いに行ってませんか？"
      when 25..29
        "あなたはとても良い人だ！素晴らしいきっと良いことがありますよ！"
      when 18..24
        "あなたは良い人だ！自信持って！"
      when 13..17
        "あなたはまあまあ良い人だ！これくらいの方が人間味があって良いよね"
      when 7..12
        "もっと周りに優しくしてあげても良いかもね"
      when 2..6
        "ちょっと心配になるかも。。。。"
      when 1
        "まさに悪童だ！逃げろ！"
      end
    end

    def answer_params
      params.require(:answer).permit(:question_id, :selected_value)
    end
end
