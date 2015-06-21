class Quiz
  def initialize(current_person, question_type:)
    @current_person = current_person
    @question_obj = question_type.new(target)
  end

  delegate :image, :question, :choices, to: :question_obj

  private

  attr_reader :current_person, :question_obj

  def target
    @target ||= Person.where("result_person.uuid <> {uuid}").params(uuid: current_person.uuid).to_a.sample
  end
end
