# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100309081731) do

  create_table "attendances", :force => true do |t|
    t.integer  "student_id"
    t.integer  "klass_id"
    t.boolean  "cancel",     :default => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "chosen",     :default => false
    t.integer  "version",    :default => 1
  end

  create_table "classes", :force => true do |t|
    t.integer  "course_id"
    t.integer  "teacher_id"
    t.integer  "classroom_id"
    t.integer  "capacity"
    t.datetime "date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "title"
    t.text     "description"
    t.boolean  "cancel"
    t.integer  "mail_sending"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classrooms", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.boolean  "inactive",    :default => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "todo_id"
  end

  create_table "course_times", :force => true do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "inactive",    :default => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_students", :id => false, :force => true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_teachers", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.integer  "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "docs", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "docs_tags", :id => false, :force => true do |t|
    t.integer  "doc_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_ja"
    t.text     "description_ja"
    t.string   "title_en"
    t.text     "description_en"
    t.integer  "registrants_count", :default => 0
    t.string   "place"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "pay_method"
    t.datetime "due_date"
    t.string   "cost"
  end

  create_table "galleries", :force => true do |t|
    t.integer  "event_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "glossaries", :force => true do |t|
    t.string   "japanese"
    t.string   "hiragana"
    t.string   "kanji"
    t.string   "english"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kanjis", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "kanjis_kunyomis", :id => false, :force => true do |t|
    t.integer "kanji_id"
    t.integer "kunyomi_id"
  end

  create_table "kanjis_meanings", :id => false, :force => true do |t|
    t.integer "kanji_id"
    t.integer "meaning_id"
  end

  create_table "kanjis_onyomis", :id => false, :force => true do |t|
    t.integer "kanji_id"
    t.integer "onyomi_id"
  end

  create_table "klasses", :force => true do |t|
    t.integer  "course_id"
    t.integer  "classroom_id"
    t.integer  "capacity",                  :default => 0
    t.datetime "date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "title"
    t.text     "description"
    t.boolean  "cancel",                    :default => false
    t.integer  "mail_sending", :limit => 1, :default => 0
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klasses_students", :id => false, :force => true do |t|
    t.integer  "student_id"
    t.integer  "klass_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kunyomis", :force => true do |t|
    t.string   "reading"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_queue", :force => true do |t|
    t.text     "mail"
    t.text     "error_info"
    t.datetime "read_at"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mail_queue", ["read_at"], :name => "index_mail_queue_on_read_at"
  add_index "mail_queue", ["sent_at"], :name => "index_mail_queue_on_sent_at"

  create_table "mails", :force => true do |t|
    t.integer  "sender_id"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meanings", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "onyomis", :force => true do |t|
    t.string   "reading"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "user_name"
    t.string   "family_name"
    t.string   "first_name"
    t.string   "family_name_kana"
    t.string   "first_name_kana"
    t.integer  "gender",              :limit => 1
    t.string   "address1"
    t.string   "address2"
    t.string   "home_phone",          :limit => 10
    t.string   "mobile_phone",        :limit => 11
    t.string   "mail_address_mobile"
    t.string   "mail_address_pc"
    t.boolean  "ritei"
    t.datetime "last_login"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "inactive"
    t.integer  "status",              :limit => 2
    t.string   "tostring"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "check"
    t.string   "language",                          :default => "ja"
  end

  create_table "photos", :force => true do |t|
    t.integer  "gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "caption_ja"
    t.string   "caption_en"
    t.integer  "user_id"
  end

  create_table "recipients", :force => true do |t|
    t.integer  "user_id"
    t.integer  "mail_id"
    t.boolean  "read",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrants", :force => true do |t|
    t.integer  "event_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "registrations", :force => true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.boolean  "cancel"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reset_passwords", :force => true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "used",       :default => false
  end

  create_table "scheduled_units", :force => true do |t|
    t.integer  "schedule_id"
    t.integer  "unit_id"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", :force => true do |t|
    t.integer  "course_id"
    t.text     "description"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.integer  "people_per_page"
    t.integer  "units_per_schedule"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "events_description_en"
    t.text     "events_description_ja"
    t.string   "version"
    t.text     "todos_description_en"
    t.text     "todos_description_ja"
    t.string   "subdomain"
  end

  create_table "students", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachings", :force => true do |t|
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "klass_id"
    t.integer  "cost"
    t.integer  "status"
  end

  create_table "template_classes", :force => true do |t|
    t.integer  "course_id"
    t.integer  "course_time_id"
    t.string   "day"
    t.string   "title"
    t.text     "description"
    t.boolean  "inactive",                    :default => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teacher_id"
    t.integer  "classroom_id"
    t.integer  "capacity",                    :default => 0
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "mail_sending",   :limit => 1, :default => 0
  end

  create_table "todos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subjects_mask"
    t.boolean  "closed",        :default => false
  end

  create_table "units", :force => true do |t|
    t.string   "unit"
    t.integer  "schedule_id"
    t.string   "title"
    t.string   "page"
    t.string   "grammar_unit"
    t.text     "description"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.string   "role"
    t.string   "occupation"
    t.string   "name"
    t.string   "name_hurigana"
    t.boolean  "male"
    t.string   "age"
    t.string   "tel"
    t.string   "nationality"
    t.string   "language"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "invitation_id"
    t.integer  "invitation_limit"
    t.integer  "login_count",         :default => 0,    :null => false
    t.integer  "failed_login_count",  :default => 0,    :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "info_update",         :default => true
  end

  create_table "versions", :force => true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.text     "changes"
    t.integer  "number"
    t.datetime "created_at"
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["versioned_type", "versioned_id"], :name => "index_versions_on_versioned_type_and_versioned_id"

  create_table "votes", :force => true do |t|
    t.integer  "todo_id"
    t.integer  "user_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
