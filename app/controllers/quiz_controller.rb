class QuizController < ApplicationController
  def show
    @image_src = quiz.image
    @question = quiz.question
    @choices = quiz.choices
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
end
