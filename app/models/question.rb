class Question
  attr_reader :target

  def initialize(person)
    @target = person
  end

  def self.question_order
    [Question::Name, Question::Department]
  end

  def self.count
    question_order.count
  end
end
