class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.date :held_on, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.references :reading_club, null: false, foreign_key: true

      t.timestamps
    end
  end
end
