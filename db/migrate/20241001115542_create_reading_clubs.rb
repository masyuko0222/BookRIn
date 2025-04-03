class CreateReadingClubs < ActiveRecord::Migration[7.1]
  def change
    create_table :reading_clubs do |t|
      t.string :title, null: false
      t.boolean :finished, default: false, null: false
      t.text :template, null: false
      t.text :read_me, null: false

      t.timestamps
    end
  end
end
