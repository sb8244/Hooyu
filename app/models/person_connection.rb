class PersonConnection
  include Neo4j::ActiveRel

  from_class Person
  to_class Person
  type 'knows'

  property :created_at
  property :updated_at
  property :weight, type: Integer
end
