class Question::Name < Question
  def question
    "What is this person's name?"
  end

  def choices
    Person.all.pluck("n.first_name + ' ' + left(n.last_name, 1)").sample(4)
  end

  def answer
    target.display_name
  end
end
