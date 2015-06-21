class QuizController < ApplicationController
  def show
    @image_src = quiz.image
    @question = quiz.question
    @choices = quiz.choices
  end

  def create
    quiz_judge.call

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

  def quiz_judge
    @quiz_judge ||= begin
      target = Person.find(session[:target_id])
      QuizJudge.new(current_person,
                    target,
                    correct: session[:correct_answer],
                    choice: params[:answer],
                    on_right: method(:on_right_answer))
    end
  end

  def on_right_answer
    session[:question] = (question_number % question_order.count) + 1
  end
end
