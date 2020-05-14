class Note < ApplicationRecord
  has_many :note_labels, dependent: :destroy
  has_many :labels, through: :note_labels

  validates_presence_of :title
end
