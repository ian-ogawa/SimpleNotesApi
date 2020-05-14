require 'rails_helper'

RSpec.describe NoteLabel, type: :model  do
  it { should belong_to(:note) }
  it { should belong_to(:label) }
end