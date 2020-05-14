class Label < ApplicationRecord
  has_many :note_labels, dependent: :destroy
  has_many :notes, through: :note_labels

  validates_presence_of :name
end
