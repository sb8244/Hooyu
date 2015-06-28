class Person
  include Neo4j::ActiveNode
  include Neo4jrb::Paperclip

  property :updated_at
  property :created_at
  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :image_url, type: String
  property :department, type: String
  property :user_id, type: Integer
  has_neo4jrb_attached_file :profile_image

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :department, presence: true
  validates :email, presence: true
  validates_attachment_content_type :profile_image, content_type: ["image/jpg", "image/jpeg", "image/png"]

  has_many :out, :knows, rel_class: PersonConnection, model_class: self
  has_many :in, :known_by, rel_class: PersonConnection, model_class: self
  has_many :out, :organizations, unique: true

  def connect_to(person, weight: 1)
    existing_connection = self.rels(between: person, type: "knows").first

    if existing_connection
      if weight > 0
        existing_connection.update!(weight: weight)
      else
        existing_connection.destroy
      end
    elsif weight > 0
      self.create_rel("knows", person, weight: weight)
    end
  end

  def display_name
    "#{first_name} #{last_name.first}."
  end
end
