class Question::Department < Question
  def question
    "What is #{target.first_name}'s department?"
  end

  def choices
    ["Todo"]
  end
end
