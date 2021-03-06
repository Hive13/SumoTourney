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

ActiveRecord::Schema.define(:version => 20110320171148) do

  create_table "contenders", :force => true do |t|
    t.string   "email",                                   :default => "", :null => false
    t.string   "encrypted_password",       :limit => 128, :default => "", :null => false
    t.string   "password_salt",                           :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.integer  "team_id"
    t.integer  "hackerspace_id"
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.string   "profile_pic_file_size"
    t.integer  "role_id"
    t.integer  "contender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contenders", ["email"], :name => "index_contenders_on_email", :unique => true
  add_index "contenders", ["reset_password_token"], :name => "index_contenders_on_reset_password_token", :unique => true

  create_table "hackerspaces", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.integer  "contender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.datetime "start"
    t.integer  "first_bot_id"
    t.integer  "second_bot_id"
    t.integer  "first_bot_round1_score"
    t.integer  "second_bot_round1_score"
    t.integer  "first_bot_round2_score"
    t.integer  "second_bot_round2_score"
    t.integer  "first_bot_round3_score"
    t.integer  "second_bot_round3_score"
    t.integer  "round"
    t.integer  "winning_bot"
    t.integer  "losing_bot"
    t.integer  "tournament_id"
    t.integer  "tournament_round"
    t.integer  "first_bot_from_match"
    t.integer  "second_bot_from_match"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "contender_id"
    t.string   "msgtype"
    t.string   "msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.integer  "contender_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sumobots", :force => true do |t|
    t.integer  "contender_id"
    t.string   "botname"
    t.string   "bot_url"
    t.integer  "wins"
    t.integer  "loses"
    t.integer  "ties"
    t.integer  "matches"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_approvals", :force => true do |t|
    t.string   "status"
    t.integer  "from_contender"
    t.integer  "to_contender"
    t.integer  "team_id"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "contender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournaments", :force => true do |t|
    t.integer  "first_place"
    t.integer  "second_place"
    t.integer  "third_place"
    t.integer  "max_rounds"
    t.integer  "current_round"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
