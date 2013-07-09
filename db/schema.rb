# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130709032535) do

  create_table "answers", :force => true do |t|
    t.string   "text"
    t.integer  "weight"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "category_scores", :force => true do |t|
    t.float   "me",          :default => 0.0, :null => false
    t.float   "roommate",    :default => 0.0, :null => false
    t.float   "importance",  :default => 0.0, :null => false
    t.integer "user_id"
    t.integer "category_id"
  end

  create_table "locations", :force => true do |t|
    t.float   "lat"
    t.float   "long"
    t.string  "address"
    t.string  "neighborhood"
    t.string  "city"
    t.string  "country"
    t.string  "zip"
    t.integer "user_id"
  end

  create_table "questions", :force => true do |t|
    t.text    "body"
    t.string  "qtype"
    t.integer "survey_id"
  end

  create_table "responses", :force => true do |t|
    t.integer  "submission_id"
    t.integer  "answer_id"
    t.integer  "question_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "submissions", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "submissions", ["survey_id", "user_id"], :name => "index_submissions_on_survey_id_and_user_id", :unique => true

  create_table "surveys", :force => true do |t|
    t.string  "title"
    t.integer "category_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "gender"
    t.date     "birthday"
    t.text     "photo"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "email"
    t.string   "password_digest"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "summary"
    t.text     "best_roommate"
    t.text     "worst_roommate"
    t.string   "pets"
    t.string   "food_preferences"
    t.string   "weekend_activity"
    t.boolean  "house"
  end

end
