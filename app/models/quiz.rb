class Quiz
  def initialize(current_person, question_type:, target:)
    @current_person = current_person
    @question_obj = question_type.new(target)
    @target = target
  end

  def image
    target.profile_image.url
  end

  delegate :question, :choices, :answer, to: :question_obj

  private

  attr_reader :current_person, :question_obj, :target
end
