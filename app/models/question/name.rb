class Question::Name < Question
  def question
    "What is this person's name?"
  end

  def choices
    ([answer] | random_choices).take(4).shuffle
  end

  def answer
    target.display_name
  end

  private

  def random_choices
    Person.all.to_a.sample(4).map{ |p| p.display_name }
  end
end
