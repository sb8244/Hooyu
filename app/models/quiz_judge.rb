class QuizJudge
  attr_reader :correct

  def initialize(person, target, correct:, choice:, on_right: lambda {}, on_wrong: lambda {})
    @correct = correct == choice
    @on_right = on_right
    @on_wrong = on_wrong
    @person = person
    @target = target
  end

  def call
    if correct
      # increase weight of person -> target
      on_right.call
    else
      # decrease weight of person -> target
      on_wrong.call
    end
  end

  private

  attr_reader :on_right, :on_wrong, :person, :target
end
