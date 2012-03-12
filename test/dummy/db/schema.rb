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

ActiveRecord::Schema.define(:version => 20120311094749) do

  create_table "espresso_articles", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "path"
    t.text     "body"
    t.text     "body_html"
    t.datetime "published_at"
    t.integer  "section_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "espresso_articles", ["path"], :name => "index_espresso_articles_on_path"

  create_table "espresso_assets", :force => true do |t|
    t.string   "file"
    t.string   "title"
    t.string   "content_type"
    t.integer  "file_size"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "espresso_comments", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "espresso_comments", ["article_id"], :name => "index_espresso_comments_on_article_id"

  create_table "espresso_sections", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "path"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "espresso_sections", ["path"], :name => "index_espresso_sections_on_path"

  create_table "espresso_taggings", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "article_id"
  end

  add_index "espresso_taggings", ["article_id"], :name => "index_espresso_taggings_on_article_id"
  add_index "espresso_taggings", ["tag_id"], :name => "index_espresso_taggings_on_tag_id"

  create_table "espresso_tags", :force => true do |t|
    t.string "name"
  end

end
