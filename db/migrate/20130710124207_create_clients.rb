class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :user_id
      t.string :hss_partner
      t.string :client_name
      t.text :street_address1
      t.text :street_address2
      t.string :city
      t.string :province
      t.string :zip_code
      t.string :contact
      t.string :contact_phone
      t.string :contact_email
      t.string :covered_entity
      t.text :covered_entity_address1
      t.text :covered_entity_address2
      t.string :covered_entity_city
      t.string :covered_entity_state
      t.string :covered_entity_zip_code
      t.string :info_security_officer
      t.string :iso_title
      t.string :iso_telephone
      t.string :iso_email
      t.string :i_t_network_name
      t.datetime :risk_assessment_report_date
      t.string :unique_project_identifier
      t.string :type_of_i_t_system
      t.string :system_categorization
      t.string :system_status
      t.string :system_configuration
      t.string :database
      t.string :network_server_o_s
      t.integer :total_servers
      t.integer :total_workstations
      t.integer :total_laptops
      t.integer :total_byods
      t.string :in_use_operating_system
      t.boolean :use_email_or_not
      t.text :in_use_products
      t.string :in_house_email_server
      t.string :firewall_model
      t.string :firewall_serial_number
      t.string :firewall_warranty_status
      t.text :firewall_in_outbound_rule1
      t.text :firewall_in_outbound_rule2
      t.text :firewall_in_outbound_rule3
      t.string :vpns
      t.string :emr_name
      t.string :emr_hosted_running
      t.string :isp_name
      t.string :isp_acc_no
      t.string :support_contract_no
      t.string :connection_type
      t.string :staic_ip_info
      t.string :network_ip
      t.string :network_subnet
      t.string :network_gateway
      t.string :network_dns1
      t.string :network_dns2
      t.string :clearinghouse
      t.string :clearinghouse_contact_no
      t.string :clearinghouse_interface_connection_type
      
      t.timestamps
    end
  end
end