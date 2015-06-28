class Question::Department < Question
  def question
    "What is #{target.first_name}'s department?"
  end

  def choices
    ([answer] | all_departments | defaults).take(4).shuffle
  end

  def answer
    target.department.titleize
  end

  private

  def all_departments
    @all_departments ||= Person.query_as(:person).pluck("DISTINCT person.department").map(&:titleize)
  end

  def defaults
    ["Engineering", "Sales", "Client Success", "General & Administrative"]
  end
end
