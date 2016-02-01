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

ActiveRecord::Schema.define(version: 20160131203016) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read",            default: false
    t.text     "user_recipients"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commentable_id"
    t.string   "commentable_type"
    t.integer  "owner_id"
    t.integer  "page_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"

  create_table "contacts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id"
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id"

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.date     "date"
    t.time     "time"
    t.string   "city"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
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

  create_table "messages", force: true do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "nfuse_pages", force: true do |t|
    t.integer  "user_id"
    t.string   "shout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_id"
    t.string   "social_flag"
    t.string   "social_key"
    t.string   "social_id"
    t.text     "url"
    t.integer  "nfuse_id"
  end

  add_index "nfuse_pages", ["nfuse_id"], name: "index_nfuse_pages_on_nfuse_id", unique: true
  add_index "nfuse_pages", ["social_id"], name: "index_nfuse_pages_on_social_id", unique: true

  create_table "pages", force: true do |t|
    t.integer "page_counter_cache", default: 0
    t.string  "page_name"
    t.string  "thing_name"
    t.string  "twitter_handle"
    t.string  "youtube_handle"
    t.string  "instagram_handle"
    t.string  "facebook_handle"
    t.string  "pinterest_handle"
    t.string  "tumblr_handle"
    t.string  "gplus_handle"
  end

  create_table "pics", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "caption"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pics", ["user_id"], name: "index_pics_on_user_id"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "follow_type"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "shouts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.string   "snip_file_name"
    t.string   "snip_content_type"
    t.integer  "snip_file_size"
    t.datetime "snip_updated_at"
    t.integer  "likes"
    t.integer  "dislikes"
    t.integer  "comments"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_video",                       default: false
    t.string   "title"
    t.string   "link"
    t.string   "uid"
    t.string   "author"
    t.string   "duration"
    t.boolean  "is_link",                        default: false
    t.boolean  "is_pic",                         default: false
    t.text     "url_html",           limit: 255
    t.text     "url",                limit: 255
    t.boolean  "has_content",                    default: false
    t.integer  "nfuse_page_id"
    t.string   "video_file_name"
    t.string   "video_content_type"
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

  create_table "snips", force: true do |t|
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "caption"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "snips", ["user_id"], name: "index_snips_on_user_id"

  create_table "tokens", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.integer  "user_id"
    t.string   "access_token_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "refresh_token"
    t.datetime "expiresat"
  end

  add_index "tokens", ["user_id"], name: "index_tokens_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "intro"
    t.integer  "gender",                  default: 1
    t.datetime "birthdate"
    t.integer  "height"
    t.integer  "relationship_status",     default: 1
    t.integer  "interested_in",           default: 1
    t.integer  "looking_for",             default: 1
    t.string   "religious_views"
    t.string   "hometown"
    t.string   "political_views"
    t.string   "occupation"
    t.string   "skills"
    t.string   "phone_number"
    t.string   "fav_movie"
    t.string   "fav_book"
    t.string   "fav_music"
    t.string   "fav_food"
    t.string   "fav_quote"
    t.string   "movie_or_play"
    t.string   "wishes"
    t.string   "tv_or_book"
    t.string   "invisible_or_read_minds"
    t.string   "lottery_or_perfect_job"
    t.string   "visit_any_country"
    t.string   "fail_or_never_try"
    t.string   "meet_in_history"
    t.string   "nobody_judges_you"
    t.string   "change_about_the_world"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "user_name"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "uid"
    t.string   "providers"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "videos", force: true do |t|
    t.string   "full_video_file_name"
    t.string   "full_video_content_type"
    t.integer  "full_video_file_size"
    t.datetime "full_video_updated_at"
    t.string   "caption"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["user_id"], name: "index_videos_on_user_id"

  create_table "votes", force: true do |t|
    t.string   "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "social_flag"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
