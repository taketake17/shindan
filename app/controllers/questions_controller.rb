class QuestionsController < ApplicationController
    
    def index
        @questions = YAML.load_file(Rails.root.join('app', 'data', 'questions.yml'))['questions']
    end

    def new
        @questions = YAML.load_file(Rails.root.join('app', 'data', 'questions.yml'))['questions']
        
    end

    def create
        answers = params[:answers]
        @total_score = calculate_result(answers)
        @evaluation = evaluate_result(@total_score)
        
        answers.each do |question_id, selected_value|
            Answer.find_or_create_by(question_id: question_id).update(selected_value: selected_value.to_i)
        end
      
        redirect_to question_result_path(total_score: @total_score, evaluation: @evaluation)
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
      

    def answer_params
        params.require(:answer).permit!
    end
end
