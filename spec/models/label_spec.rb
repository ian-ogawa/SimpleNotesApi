require 'rails_helper'

RSpec.describe Label, type: :model  do
  it { should have_many(:note_labels).dependent(:destroy) }
  it { should have_many(:notes) }

  it { should validate_presence_of(:name) }
end