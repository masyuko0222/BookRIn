class CreateReadingClubs < ActiveRecord::Migration[7.1]
  def change
    create_table :reading_clubs do |t|
      t.string :title, null: false
      t.boolean :finished, null: false
      t.text :template
      t.text :read_me

      t.timestamps
    end
  end
end
