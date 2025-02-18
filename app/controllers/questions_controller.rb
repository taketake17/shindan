class QuestionsController < ApplicationController
    def index
        @questions = YAML.load_file(Rails.root.join("app", "data", "questions.yml"))["questions"]
    end

    def new
        @questions = YAML.load_file(Rails.root.join("app", "data", "questions.yml"))["questions"]
    end


    def create
        @questions = YAML.load_file(Rails.root.join("app", "data", "questions.yml"))["questions"]
        answers = params[:answers].present? ? params[:answers].to_unsafe_h : {}
        @answers = @questions.map do |question|
            Answer.new(question_id: question["id"], selected_value: answers[question["id"].to_s]
            )
        end

        if @answers.all?(&:valid?)
            @total_score = calculate_result(answers)
            @evaluation = evaluate_result(@total_score)
            @answers.each(&:save)
            redirect_to question_result_path(total_score: @total_score, evaluation: @evaluation)
        else
            flash.now[:error] = "全ての項目を入力してください"
            render :new, status: :unprocessable_entity
        end
    end


    def show
        @total_score = params[:total_score].to_i
        @evaluation = params[:evaluation]
    end

    def result
        @total_score = params[:total_score].to_i
        @evaluation = params[:evaluation]
    end


    private

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
