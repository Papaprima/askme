# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_31_083042) do

  create_table "hashtags", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_hashtags", force: :cascade do |t|
    t.integer "hashtag_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hashtag_id"], name: "index_question_hashtags_on_hashtag_id"
    t.index ["question_id"], name: "index_question_hashtags_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "text"
    t.string "answer"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "author_id"
    t.index ["author_id"], name: "index_questions_on_author_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_hash"
    t.string "password_salt"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_color_background"
  end

end
