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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160111223954) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "avg",           limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collection_language", force: :cascade do |t|
    t.string   "locale",                  limit: 255,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "collection_name",         limit: 255
    t.text     "collection_description_", limit: 65535
  end

  add_index "collection_language", ["locale"], name: "index_collection_translations_on_locale", using: :btree

  create_table "collection_translations", force: :cascade do |t|
    t.integer  "collection_id",           limit: 4,     null: false
    t.string   "locale",                  limit: 255,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "collection_name",         limit: 255
    t.text     "collection_description_", limit: 65535
  end

  add_index "collection_translations", ["collection_id"], name: "index_collection_translations_on_collection_id", using: :btree
  add_index "collection_translations", ["locale"], name: "index_collection_translations_on_locale", using: :btree

  create_table "collections", force: :cascade do |t|
    t.datetime "date_time"
    t.string   "collection_name",         limit: 255
    t.text     "collection_description_", limit: 65535
    t.string   "user_id",                 limit: 255
    t.text     "featured",                limit: 65535
    t.text     "home",                    limit: 65535
    t.string   "image_file_name",         limit: 255
    t.string   "image_content_type",      limit: 255
    t.integer  "image_file_size",         limit: 4
    t.datetime "image_updated_at"
    t.boolean  "is_featured?",            limit: 1
    t.boolean  "is_home?",                limit: 1
    t.string   "slug",                    limit: 255
    t.integer  "titles_count",            limit: 4,     default: 0, null: false
  end

  create_table "collections_users", force: :cascade do |t|
    t.integer "user_id",       limit: 4
    t.integer "collection_id", limit: 4
  end

  add_index "collections_users", ["collection_id"], name: "index_collections_users_on_collection_id", using: :btree
  add_index "collections_users", ["user_id"], name: "index_collections_users_on_user_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string  "country_code",      limit: 255
    t.string  "geographic_region", limit: 255
    t.string  "country",           limit: 100
    t.text    "active",            limit: 65535
    t.boolean "is_active?",        limit: 1
    t.string  "slug",              limit: 255
    t.integer "titles_count",      limit: 4,     default: 0, null: false
  end

  add_index "countries", ["country"], name: "fb_join_fk_country_INDEX", using: :btree

  create_table "country_titles", force: :cascade do |t|
    t.integer "title_id",   limit: 4
    t.integer "country_id", limit: 4
    t.text    "params",     limit: 65535
  end

  add_index "country_titles", ["country_id"], name: "fb_repeat_el_country_INDEX", using: :btree
  add_index "country_titles", ["title_id"], name: "fb_parent_fk_parent_id_INDEX", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "film_requests", force: :cascade do |t|
    t.text     "comment",          limit: 65535
    t.string   "film_name",        limit: 255
    t.string   "approximate_year", limit: 255
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "genre_titles", force: :cascade do |t|
    t.integer "title_id", limit: 4
    t.integer "genre_id", limit: 4
    t.text    "params",   limit: 65535
  end

  add_index "genre_titles", ["genre_id"], name: "fb_repeat_el_Genres_INDEX", using: :btree
  add_index "genre_titles", ["title_id"], name: "fb_parent_fk_parent_id_INDEX", using: :btree

  create_table "genres", force: :cascade do |t|
    t.datetime "date_time"
    t.string   "genre_english", limit: 255
    t.string   "genre_espanol", limit: 255
    t.text     "active",        limit: 65535
    t.boolean  "is_active?",    limit: 1
    t.string   "slug",          limit: 255
    t.integer  "titles_count",  limit: 4,     default: 0, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.integer  "receiver_id",   limit: 4
    t.string   "receiver_type", limit: 255
    t.text     "message",       limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "messages", ["author_type", "author_id"], name: "index_messages_on_author_type_and_author_id", using: :btree
  add_index "messages", ["receiver_type", "receiver_id"], name: "index_messages_on_receiver_type_and_receiver_id", using: :btree

  create_table "movie_stream_link_types", force: :cascade do |t|
    t.string   "typel",                   limit: 255
    t.string   "logo_file_name",          limit: 255
    t.string   "logo_content_type",       limit: 255
    t.integer  "logo_file_size",          limit: 4
    t.datetime "logo_updated_at"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "transactionType",         limit: 2
    t.string   "transaction_type",        limit: 255
    t.string   "small_logo_file_name",    limit: 255
    t.string   "small_logo_content_type", limit: 255
    t.integer  "small_logo_file_size",    limit: 4
    t.datetime "small_logo_updated_at"
    t.boolean  "visible",                 limit: 1,   default: true
  end

  create_table "movie_streams", force: :cascade do |t|
    t.string  "typel",                     limit: 255
    t.string  "link",                      limit: 255
    t.decimal "price",                                   precision: 10, scale: 2
    t.integer "title_id",                  limit: 4,                                              null: false
    t.string  "external_id",               limit: 255,                            default: "",    null: false
    t.text    "logo",                      limit: 65535
    t.boolean "protect",                   limit: 1,                              default: false
    t.integer "movie_stream_link_type_id", limit: 4
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "notifier_id",         limit: 4
    t.string   "notifier_type",       limit: 255
    t.boolean  "email",               limit: 1
    t.string   "notification_period", limit: 255
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "notifications", ["notifier_type", "notifier_id"], name: "index_notifications_on_notifier_type_and_notifier_id", using: :btree

  create_table "overall_averages", force: :cascade do |t|
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "overall_avg",   limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "platform_update_logs", force: :cascade do |t|
    t.integer  "title_id",   limit: 4
    t.string   "body",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.datetime "date_time"
    t.integer  "collection_id", limit: 4
    t.integer  "title_id",      limit: 4
  end

  add_index "playlists", ["collection_id"], name: "fb_join_fk_Playlist_name_INDEX", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.string   "name",                limit: 255
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "stars",         limit: 24,  null: false
    t.string   "dimension",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id",   limit: 4
    t.string   "cacheable_type", limit: 255
    t.float    "avg",            limit: 24,  null: false
    t.integer  "qty",            limit: 4,   null: false
    t.string   "dimension",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "titles", force: :cascade do |t|
    t.datetime "date_time"
    t.string   "film_title",                limit: 255
    t.string   "alt_title",                 limit: 255
    t.string   "year_produced",             limit: 255
    t.text     "snappy_summary",            limit: 65535
    t.text     "long_description_espanol",  limit: 65535
    t.text     "key_art",                   limit: 65535
    t.text     "actors",                    limit: 65535
    t.string   "director",                  limit: 255
    t.text     "imdb",                      limit: 65535
    t.string   "internal_comments",         limit: 255
    t.text     "butaca_owned",              limit: 65535
    t.text     "short_description_espanol", limit: 65535
    t.string   "duration",                  limit: 255
    t.string   "film_rating",               limit: 255
    t.text     "active",                    limit: 65535
    t.string   "ref_movie_id",              limit: 255
    t.integer  "meta_verified",             limit: 4
    t.datetime "date_updated_can_istream"
    t.string   "key_art_file_name",         limit: 255
    t.string   "key_art_content_type",      limit: 255
    t.integer  "key_art_file_size",         limit: 4
    t.datetime "key_art_updated_at"
    t.boolean  "is_active?",                limit: 1,     default: true
    t.string   "slug",                      limit: 255
    t.boolean  "not_found",                 limit: 1,     default: false, null: false
    t.integer  "position",                  limit: 4
  end

  add_index "titles", ["film_title"], name: "filmTitle", using: :btree

  create_table "user_favorites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "title_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_log_activities", force: :cascade do |t|
    t.string   "message",         limit: 255
    t.integer  "notification_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "readed",          limit: 1,   default: false
  end

  create_table "user_queues", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "title_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_removals", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "title_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                    limit: 255,   default: "", null: false
    t.string   "encrypted_password",       limit: 255,   default: "", null: false
    t.string   "reset_password_token",     limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",       limit: 255
    t.string   "last_sign_in_ip",          limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "avatar_file_name",         limit: 255
    t.string   "avatar_content_type",      limit: 255
    t.integer  "avatar_file_size",         limit: 4
    t.datetime "avatar_updated_at"
    t.string   "notification_preferences", limit: 255
    t.string   "name",                     limit: 255
    t.text     "bio",                      limit: 65535
    t.string   "first_name",               limit: 255
    t.string   "last_name",                limit: 255
    t.integer  "country_id",               limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "profiles", "users"
end
