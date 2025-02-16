class QuestionsController < ApplicationController
    def index
        @questions = YAML.load_file(Rails.root.join('app', 'data', 'questions.yml'))['questions']
    end

    def new
        @questions = YAML.load_file(Rails.root.join('app', 'data', 'questions.yml'))['questions']
        @question = Question.new
    end

    def show
        @question = Question.find(params[:id])
        @result = calculate_result(@question)
        @evaluation = evaluate_result(@result)
    end

    def create
        @question = Question.new(question_params)
        if @question.save
            session[:result] = @result
            session[:evaluation] = @evaluation
            flash[:notice] = "診断が完了しました"
            redirect_to question_path(@question)
        else
          redirect_to action: "new"
        end
    end

    private

    def calculate_result(question)
       (1..4).map { |i| question.send("question#{i}") }.map(&:to_i).sum
    end

    def evaluate_result(result)
        case result 
        when 12
            "マジで言ってます？良い人狙いに行ってませんか？"
        when 10..11
            "とても良い人だ！素晴らしい！"
        when 8..9
            "良い人だ！自信持って！"    
        when 6..7
            "まあまあ良い人だ！これくらいの方が人間味があって良いよね"
        when 4..5
            "もっと周りに優しくしてあげても良いかもね"
        when 1..3
            "ちょっと心配になるかも。。。。"    
        when 0
            "まさに悪童だ！逃げろ！"
        end
    end 

    def question_params
        params.require(:question).permit(:question1, :question2, :question3, :question4)
    end
end
