class QuizController < ApplicationController
  def show
    @image_src = quiz.image
    @question = quiz.question
    @choices = quiz.choices
  end

  def create
    quiz_judger.call
    redirect_to action: "show"
  end

  private

  def quiz
    @quiz ||= Quiz.new(current_person, question_type: next_question_type)
  end

  def next_question_type
    @next_question_type ||= question_order[question_number - 1]
  end

  def question_order
    [Question::Name, Question::Department]
  end

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

  def handle_wrong_answer(correct_answer)
    flash[:error] = "Not quite...The answer is #{correct_answer}."
    reset_quiz_flow
  end

  def handle_correct_answer(correct_answer)
    flash[:success] = "You got it!"
    session[:question] = question_number + 1
    reset_quiz_flow if session[:question] > question_order.count
  end

  def reset_quiz_flow
    session[:question] = 1
    session[:target_id] = nil
  end
end
