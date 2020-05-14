require 'rails_helper'

RSpec.describe Note, type: :model  do
  it { should have_many(:note_labels).dependent(:destroy) }
  it { should have_many(:labels) }

  it { should validate_presence_of(:title) }
end