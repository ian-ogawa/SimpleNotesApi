class CreateNoteLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :note_labels do |t|
      t.references :note, foreign_key: true
      t.references :label, foreign_key: true

      t.timestamps
    end
  end
end
