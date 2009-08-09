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

ActiveRecord::Schema.define(:version => 20090719052342) do

  create_table "attendances", :force => true do |t|
    t.integer  "student_id"
    t.integer  "klass_id"
    t.boolean  "cancel",     :default => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "chosen",     :default => false
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
    t.boolean  "inactive"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "inactive"
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

  create_table "klasses", :force => true do |t|
    t.integer  "course_id"
    t.integer  "teacher_id"
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
    t.string   "tostring"
  end

  create_table "klasses_students", :id => false, :force => true do |t|
    t.integer  "student_id"
    t.integer  "klass_id"
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

  create_table "registrations", :force => true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.boolean  "cancel"
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
    t.integer  "course_id"
    t.integer  "cost",       :default => 1500
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
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

end
