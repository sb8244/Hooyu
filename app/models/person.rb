class Person
  include Neo4j::ActiveNode

  property :updated_at
  property :created_at
  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :image_url, type: String
  property :department, type: String

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :department, presence: true
  validates :email, presence: true

  has_many :out, :knows, rel_class: PersonConnection, model_class: self
  has_many :in, :known_by, rel_class: PersonConnection, model_class: self

  def connect_to(person)
    existing_connection = self.rels(between: person, type: "knows").first

    if existing_connection
      existing_connection.update!(weight: existing_connection.weight + 1)
    else
      self.create_rel("knows", person, weight: 1)
    end
  end
end
