class Question
  attr_reader :target

  def initialize(person)
    @target = person
  end

  def image
    target.image_url
  end
end
