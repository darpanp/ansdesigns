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

ActiveRecord::Schema.define(:version => 20120524021338) do

  create_table "contact_us", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "customer_id"
    t.string   "order_id"
    t.boolean  "is_quote",              :default => false
    t.string   "order_type"
    t.string   "order_density"
    t.string   "order_qty_or_hour"
    t.string   "price_per_qty_or_hour"
    t.string   "order_status"
    t.string   "order_subtotal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "send_emails", :force => true do |t|
    t.string   "customer_id"
    t.string   "order_id"
    t.string   "is_quote"
    t.date     "reminder_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "fullname"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "customer_id"
    t.string   "salt"
    t.string   "encrypted_password"
    t.boolean  "is_quote",           :default => false
    t.string   "user_role",          :default => "CUSTOMER"
  end

  add_index "users", ["customer_id"], :name => "index_users_on_customer_id", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
