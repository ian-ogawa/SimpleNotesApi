class LabelSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :notes
end
