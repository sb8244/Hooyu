class QuizController < ApplicationController
  def show
    @image_src = quiz.image
    @question = quiz.question
    @choices = quiz.choices

    session[:target_id] = target.id
    session[:correct_answer] = quiz.answer
  end

  private

  def target
    @target ||= if session[:target_id]
                  Person.find(session[:target_id])
                else
                  Person.where("result_person.uuid <> {uuid}").params(uuid: current_person.uuid).to_a.sample
                end
  end

  def quiz
    @quiz ||= Quiz.new(current_person, question_type: next_question_type, target: target)
  end

  def next_question_type
    @next_question_type ||= Question.question_order[question_number - 1]
  end

  def question_number
    session[:question] || 1
  end
end
