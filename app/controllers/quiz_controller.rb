class QuizController < ApplicationController
  def show
    @image_src = quiz.image
    @question = quiz.question
    @choices = quiz.choices

    session[:target_id] = target.id
    session[:correct_answer] = quiz.answer
  end

  def create
    quiz_judger.call
    redirect_to action: "show"
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

  def handle_wrong_answer(from, to, correct_answer)
    flash[:error] = "Not quite...The answer is #{correct_answer}."
    reset_quiz_flow
  end

  def handle_correct_answer(from, to, correct_answer)
    flash[:success] = "You got it!"
    from.connect_to(to, weight: question_number)
    session[:question] = question_number + 1
    reset_quiz_flow if session[:question] > question_order.count
  end

  def reset_quiz_flow
    session[:question] = 1
    session[:target_id] = nil
  end
end
