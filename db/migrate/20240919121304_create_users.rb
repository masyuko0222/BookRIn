class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :uid, null: false
      t.string :name, null: false
      t.string :provider, null: false

      t.timestamps
    end

    add_index :users, [:uid, :provider], unique: true
  end
end
