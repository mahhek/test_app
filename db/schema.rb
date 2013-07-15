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

ActiveRecord::Schema.define(:version => 20130711053825) do

  create_table "client_contacts", :force => true do |t|
    t.integer  "client_id"
    t.string   "company"
    t.string   "name"
    t.string   "title"
    t.string   "phone"
    t.string   "email"
    t.string   "participate_in"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "client_interfaces", :force => true do |t|
    t.integer  "client_id"
    t.string   "interface_name"
    t.string   "contact_number"
    t.string   "interface_connection_type"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "clients", :force => true do |t|
    t.integer  "user_id"
    t.string   "hss_partner"
    t.string   "client_name"
    t.text     "street_address1"
    t.text     "street_address2"
    t.string   "city"
    t.string   "province"
    t.string   "zip_code"
    t.string   "contact"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "covered_entity"
    t.text     "covered_entity_address1"
    t.text     "covered_entity_address2"
    t.string   "covered_entity_city"
    t.string   "covered_entity_state"
    t.string   "covered_entity_zip_code"
    t.string   "info_security_officer"
    t.string   "iso_title"
    t.string   "iso_telephone"
    t.string   "iso_email"
    t.string   "i_t_network_name"
    t.datetime "risk_assessment_report_date"
    t.string   "unique_project_identifier"
    t.string   "type_of_i_t_system"
    t.string   "system_categorization"
    t.string   "system_status"
    t.string   "system_configuration"
    t.string   "database"
    t.string   "network_server_o_s"
    t.integer  "total_servers"
    t.integer  "total_workstations"
    t.integer  "total_laptops"
    t.integer  "total_byods"
    t.string   "in_use_operating_system"
    t.boolean  "use_email_or_not"
    t.text     "in_use_products"
    t.string   "in_house_email_server"
    t.string   "firewall_model"
    t.string   "firewall_serial_number"
    t.string   "firewall_warranty_status"
    t.text     "firewall_in_outbound_rule1"
    t.text     "firewall_in_outbound_rule2"
    t.text     "firewall_in_outbound_rule3"
    t.string   "vpns"
    t.string   "emr_name"
    t.string   "emr_hosted_running"
    t.string   "isp_name"
    t.string   "isp_acc_no"
    t.string   "support_contract_no"
    t.string   "connection_type"
    t.string   "staic_ip_info"
    t.string   "network_ip"
    t.string   "network_subnet"
    t.string   "network_gateway"
    t.string   "network_dns1"
    t.string   "network_dns2"
    t.string   "clearinghouse"
    t.string   "clearinghouse_contact_no"
    t.string   "clearinghouse_interface_connection_type"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",   :null => false
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "role"
    t.string   "fname"
    t.string   "lname"
    t.string   "company"
    t.string   "phone"
    t.boolean  "is_active",              :default => true
    t.integer  "client_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
