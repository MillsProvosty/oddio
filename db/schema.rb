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

ActiveRecord::Schema.define(version: 2019_07_22_215652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "app_auths", force: :cascade do |t|
    t.bigint "user_id"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_app_auths_on_user_id"
  end

  create_table "google_auths", force: :cascade do |t|
    t.bigint "user_id"
    t.string "uid"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_google_auths_on_user_id"
  end

  create_table "landmarks", force: :cascade do |t|
    t.string "name"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "long", precision: 10, scale: 6
    t.string "address"
    t.string "phone_number"
    t.string "category"
    t.string "place_id"
    t.string "website"
    t.string "photo_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
<<<<<<< HEAD

=======
>>>>>>> 0c632e3cd28354975b2cdd0b0cb1d587eb85f254
    t.string "md5_hash"
  end

  create_table "recordings", force: :cascade do |t|
    t.string "title"
    t.text "url"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "landmark_id"
    t.index ["landmark_id"], name: "index_recordings_on_landmark_id"
    t.index ["user_id"], name: "index_recordings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "display_name"
    t.string "vote_token"
  end

<<<<<<< HEAD
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"

=======
>>>>>>> 0c632e3cd28354975b2cdd0b0cb1d587eb85f254
  add_foreign_key "app_auths", "users"
  add_foreign_key "google_auths", "users"
  add_foreign_key "recordings", "landmarks"
  add_foreign_key "recordings", "users"
end
