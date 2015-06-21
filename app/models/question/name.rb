class Question::Name < Question
  def question
    "What is this person's name?"
  end

  # TODO: Pick 4 random people's names
  def choices
    Person.all.to_a.sample(4).map{ |p| p.display_name }
  end

  def answer
    target.display_name
  end
end
