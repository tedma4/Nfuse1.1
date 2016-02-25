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

ActiveRecord::Schema.define(version: 20160224004737) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type",  limit: 255
    t.integer  "owner_id"
    t.string   "owner_type",      limit: 255
    t.string   "key",             limit: 255
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read",                        default: false
    t.text     "user_recipients"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commentable_id",            limit: 255
    t.string   "commentable_type",          limit: 255
    t.integer  "owner_id"
    t.integer  "page_id"
    t.integer  "comment_id"
    t.string   "ancestry"
    t.string   "image_upload_file_name"
    t.string   "image_upload_content_type"
    t.integer  "image_upload_file_size"
    t.datetime "image_upload_updated_at"
    t.text     "url"
    t.text     "url_html"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry"
  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id"
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id"

  create_table "events", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.text     "description"
    t.string   "cover_file_name",    limit: 255
    t.string   "cover_content_type", limit: 255
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.date     "date"
    t.time     "time"
    t.string   "city",               limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "nfuse_pages", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "shout_id",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_id",    limit: 255
    t.string   "social_flag", limit: 255
    t.string   "social_key",  limit: 255
    t.string   "social_id",   limit: 255
    t.text     "url"
    t.integer  "nfuse_id"
  end

  add_index "nfuse_pages", ["nfuse_id"], name: "index_nfuse_pages_on_nfuse_id", unique: true
  add_index "nfuse_pages", ["social_id"], name: "index_nfuse_pages_on_social_id", unique: true

  create_table "pages", force: :cascade do |t|
    t.integer  "page_counter_cache",                   default: 0
    t.string   "page_name",                limit: 255
    t.string   "thing_name",               limit: 255
    t.string   "twitter_handle",           limit: 255
    t.string   "youtube_handle",           limit: 255
    t.string   "instagram_handle",         limit: 255
    t.string   "facebook_handle",          limit: 255
    t.string   "pinterest_handle",         limit: 255
    t.string   "tumblr_handle",            limit: 255
    t.string   "gplus_handle",             limit: 255
    t.string   "metatag_title"
    t.text     "description"
    t.string   "page_avatar_file_name"
    t.string   "page_avatar_content_type"
    t.integer  "page_avatar_file_size"
    t.datetime "page_avatar_updated_at"
  end

  add_index "pages", ["page_name"], name: "index_pages_on_page_name"

  create_table "pics", force: :cascade do |t|
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "caption",            limit: 255
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pics", ["user_id"], name: "index_pics_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "follow_type", limit: 255
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "shouts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.string   "pic_file_name",      limit: 255
    t.string   "pic_content_type",   limit: 255
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.string   "snip_file_name",     limit: 255
    t.string   "snip_content_type",  limit: 255
    t.integer  "snip_file_size"
    t.datetime "snip_updated_at"
    t.integer  "likes"
    t.integer  "dislikes"
    t.integer  "comments"
    t.string   "permalink",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_video",                       default: false
    t.string   "title",              limit: 255
    t.string   "link",               limit: 255
    t.string   "uid",                limit: 255
    t.string   "author",             limit: 255
    t.string   "duration",           limit: 255
    t.boolean  "is_link",                        default: false
    t.boolean  "is_pic",                         default: false
    t.text     "url_html",           limit: 255
    t.text     "url",                limit: 255
    t.boolean  "has_content",                    default: false
    t.integer  "nfuse_page_id"
    t.string   "video_file_name",    limit: 255
    t.string   "video_content_type", limit: 255
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.boolean  "is_full_video",                  default: false
    t.boolean  "is_exclusive",                   default: false
    t.integer  "cached_votes_total",             default: 0
    t.integer  "cached_votes_score",             default: 0
  end

  add_index "shouts", ["cached_votes_score"], name: "index_shouts_on_cached_votes_score"
  add_index "shouts", ["cached_votes_total"], name: "index_shouts_on_cached_votes_total"
  add_index "shouts", ["permalink"], name: "index_shouts_on_permalink"
  add_index "shouts", ["uid"], name: "index_shouts_on_uid", unique: true
  add_index "shouts", ["user_id", "created_at"], name: "index_shouts_on_user_id_and_created_at"

  create_table "snips", force: :cascade do |t|
    t.string   "video_file_name",    limit: 255
    t.string   "video_content_type", limit: 255
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "caption",            limit: 255
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "snips", ["user_id"], name: "index_snips_on_user_id"

  create_table "tokens", force: :cascade do |t|
    t.string   "provider",            limit: 255
    t.string   "uid",                 limit: 255
    t.string   "access_token",        limit: 255
    t.integer  "user_id"
    t.string   "access_token_secret", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "refresh_token",       limit: 255
    t.datetime "expiresat"
  end

  add_index "tokens", ["user_id"], name: "index_tokens_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "email",                   limit: 255
    t.string   "password_digest",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",          limit: 255
    t.boolean  "admin"
    t.string   "avatar_file_name",        limit: 255
    t.string   "avatar_content_type",     limit: 255
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "intro"
    t.integer  "gender",                              default: 1
    t.datetime "birthdate"
    t.integer  "height"
    t.integer  "relationship_status",                 default: 1
    t.integer  "interested_in",                       default: 1
    t.integer  "looking_for",                         default: 1
    t.string   "religious_views",         limit: 255
    t.string   "hometown",                limit: 255
    t.string   "political_views",         limit: 255
    t.string   "occupation",              limit: 255
    t.string   "skills",                  limit: 255
    t.string   "phone_number",            limit: 255
    t.string   "fav_movie",               limit: 255
    t.string   "fav_book",                limit: 255
    t.string   "fav_music",               limit: 255
    t.string   "fav_food",                limit: 255
    t.string   "fav_quote",               limit: 255
    t.string   "movie_or_play",           limit: 255
    t.string   "wishes",                  limit: 255
    t.string   "tv_or_book",              limit: 255
    t.string   "invisible_or_read_minds", limit: 255
    t.string   "lottery_or_perfect_job",  limit: 255
    t.string   "visit_any_country",       limit: 255
    t.string   "fail_or_never_try",       limit: 255
    t.string   "meet_in_history",         limit: 255
    t.string   "nobody_judges_you",       limit: 255
    t.string   "change_about_the_world",  limit: 255
    t.string   "auth_token",              limit: 255
    t.string   "password_reset_token",    limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "user_name",               limit: 255
    t.string   "banner_file_name",        limit: 255
    t.string   "banner_content_type",     limit: 255
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "uid",                     limit: 255
    t.string   "providers",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "videos", force: :cascade do |t|
    t.string   "full_video_file_name",    limit: 255
    t.string   "full_video_content_type", limit: 255
    t.integer  "full_video_file_size"
    t.datetime "full_video_updated_at"
    t.string   "caption",                 limit: 255
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["user_id"], name: "index_videos_on_user_id"

  create_table "votes", force: :cascade do |t|
    t.string   "votable_id",   limit: 255
    t.string   "votable_type", limit: 255
    t.integer  "voter_id"
    t.string   "voter_type",   limit: 255
    t.boolean  "vote_flag"
    t.string   "vote_scope",   limit: 255
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "social_flag",  limit: 255
    t.integer  "owner_id"
    t.string   "owner_type",   limit: 255
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
