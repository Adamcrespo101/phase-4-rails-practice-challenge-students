class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :major
  
  belongs_to :instructor
end
