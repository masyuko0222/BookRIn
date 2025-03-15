# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_15_140452) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notes", force: :cascade do |t|
    t.date "held_on", null: false
    t.string "title"
    t.text "content"
    t.bigint "reading_club_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reading_club_id"], name: "index_notes_on_reading_club_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "reading_club_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reading_club_id"], name: "index_participants_on_reading_club_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "reading_clubs", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "finished", null: false
    t.text "template", default: "### これはテンプレート例です\n  - 「ノートを新規作成」ボタンを押して、新しいノートを作成しましょう！\n  - 作成したノートは共同編集ができます。輪読会で学んだことをみんなで記録しましょう😀\n\n### 今日読んだ範囲\n   - 「第〇章 p.xx」～「第〇章 p.yy」\n\n### 学んだこと・分かったこと\n  - Aさん\n    - 〇〇というメソッドは、配列を△△したいときに利用する\n  - Bさん\n  - Cさん\n"
    t.text "read_me", default: "# READ ME\n**輪読会のルールや読んで欲しいことを書きましょう！**\n\n## 開催日時\n- 毎週月曜日 20:00~\n- 毎週水曜日 20:00~\n- 祝日はお休みです\n\n## Discordリンク\n[リンク](https://example.com/)\n"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name", null: false
    t.string "provider", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "notes", "reading_clubs"
  add_foreign_key "participants", "reading_clubs"
  add_foreign_key "participants", "users"
end
