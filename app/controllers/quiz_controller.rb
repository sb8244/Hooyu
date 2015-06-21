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
    Question::Name
  end
end
