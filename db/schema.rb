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

ActiveRecord::Schema.define(:version => 20131201060558) do

  create_table "customer_contacts", :force => true do |t|
    t.integer  "customer_id"
    t.string   "title"
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "position"
  end

  create_table "customer_shippings", :force => true do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.string   "address"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "position"
  end

  create_table "customers", :force => true do |t|
    t.string   "code",                         :null => false
    t.string   "name",                         :null => false
    t.string   "remark"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "customers", ["code"], :name => "index_customers_on_code", :unique => true

  create_table "departments", :force => true do |t|
    t.string   "name",                         :null => false
    t.string   "descript"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "departments", ["name"], :name => "index_departments_on_name", :unique => true

  create_table "employees", :force => true do |t|
    t.string   "code",            :limit => 20, :null => false
    t.string   "name",                          :null => false
    t.string   "email"
    t.string   "phone"
    t.string   "mobile"
    t.string   "office_location"
    t.integer  "department_id"
    t.integer  "job_id"
    t.integer  "sex"
    t.string   "id_card"
    t.string   "home_addr"
    t.date     "date_of_birth"
    t.string   "remark"
    t.date     "date_of_leaved"
    t.boolean  "active"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "employees", ["code"], :name => "index_employees_on_code", :unique => true

  create_table "items", :id => false, :force => true do |t|
    t.string   "type"
    t.integer  "item_id"
    t.integer  "order"
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "items", ["type", "item_id"], :name => "index_items_on_type_and_item_id", :unique => true
  add_index "items", ["type", "name"], :name => "index_items_on_type_and_name", :unique => true

  create_table "jobs", :force => true do |t|
    t.string   "name",                         :null => false
    t.string   "descript"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "jobs", ["name"], :name => "index_jobs_on_name", :unique => true

  create_table "products", :force => true do |t|
    t.string   "code",          :null => false
    t.string   "name",          :null => false
    t.integer  "customer_id"
    t.string   "specification"
    t.string   "remark"
    t.integer  "active"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "products", ["code"], :name => "index_products_on_code", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "stock_locations", :force => true do |t|
    t.integer  "stock_type", :null => false
    t.string   "building",   :null => false
    t.integer  "floor",      :null => false
    t.string   "name",       :null => false
    t.string   "remark"
    t.integer  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "stock_locations", ["stock_type", "building", "floor", "name"], :name => "index_stock_location", :unique => true

  create_table "stock_products", :force => true do |t|
    t.integer  "stock_id",          :null => false
    t.integer  "product_id",        :null => false
    t.integer  "stock_location_id", :null => false
    t.integer  "quantity",          :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "stocks", :force => true do |t|
    t.string   "bill_no",         :null => false
    t.string   "spare_no"
    t.date     "handle_date",     :null => false
    t.integer  "stock_type"
    t.integer  "type",            :null => false
    t.integer  "workshop_id"
    t.string   "handover_person"
    t.string   "handle_person"
    t.integer  "status",          :null => false
    t.string   "remark"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
