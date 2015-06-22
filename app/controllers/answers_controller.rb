class AnswersController < ApplicationController
  def create
    quiz_judger.call

    head :no_content
  end

  private

  def question_number
    session[:question] || 1
  end

  def quiz_judger
    @quiz_judger ||= begin
      QuizJudge.new(current_person,
                    Person.find(session[:target_id]),
                    correct: session[:correct_answer],
                    choice: params[:answer],
                    on_right: method(:handle_correct_answer),
                    on_wrong: method(:handle_wrong_answer)
      )
    end
  end

  def handle_wrong_answer(from, to, correct_answer)
    flash[:error] = "Not quite...The answer is #{correct_answer}."
    reset_quiz_flow
  end

  def handle_correct_answer(from, to, correct_answer)
    flash[:success] = "You got it!"
    from.connect_to(to, weight: question_number)
    session[:question] = question_number + 1
    reset_quiz_flow if session[:question] > Question.count
  end

  def reset_quiz_flow
    session[:question] = 1
    session[:target_id] = nil
  end
end
