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

ActiveRecord::Schema.define(:version => 20120410184708) do

  create_table "cart_items", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "order_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "status"
    t.text     "billing_address"
    t.text     "shipping_address"
  end

  create_table "product_categories", :force => true do |t|
    t.integer "product_id"
    t.integer "category_id"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price_in_cents"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.datetime "deleted_at"
    t.boolean  "retired",        :default => false, :null => false
    t.string   "photo_url"
  end

  create_table "users", :force => true do |t|
    t.string   "email",            :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "full_name"
    t.string   "display_name"
    t.text     "billing_address"
    t.text     "shipping_address"
    t.boolean  "admin"
  end

end
