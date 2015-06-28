class Organization
  include Neo4j::ActiveNode

  property :updated_at
  property :created_at
  property :name, type: String
  property :domain, type: String

  has_many :in, :people, unique: true

  def departments
    people.pluck("DISTINCT result_people.department").map(&:titleize)
  end
end
