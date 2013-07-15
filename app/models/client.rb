class Client < ActiveRecord::Base
  attr_accessible :user_id, :client_interfaces_attributes, :client_contacts_attributes, :hss_partner, :client_name, :street_address1, :street_address2, :city, :province, :zip_code, :contact, :contact_phone, :contact_email, :covered_entity, :covered_entity_address1, :covered_entity_address2, :covered_entity_city, :covered_entity_state, :covered_entity_zip_code, :info_security_officer, :iso_title, :iso_telephone, :iso_email, :i_t_network_name, :risk_assessment_report_date, :unique_project_identifier, :type_of_i_t_system, :system_categorization, :system_status, :system_configuration, :database, :network_server_o_s, :total_servers, :total_workstations, :total_laptops, :total_byods, :in_use_operating_system, :use_email_or_not, :in_use_products, :in_house_email_server, :firewall_model, :firewall_serial_number, :firewall_warranty_status, :firewall_in_outbound_rule1, :firewall_in_outbound_rule2, :firewall_in_outbound_rule3, :vpns, :emr_name, :emr_hosted_running, :isp_name, :isp_acc_no, :support_contract_no, :connection_type, :staic_ip_info, :network_ip, :network_subnet, :network_gateway, :network_dns1, :network_dns2, :clearinghouse, :clearinghouse_contact_no, :clearinghouse_interface_connection_type

  has_many :client_contacts, dependent: :destroy
  has_many :client_interfaces, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :client_contacts, allow_destroy: true
  accepts_nested_attributes_for :client_interfaces, allow_destroy: true
  validates_presence_of :hss_partner, :client_name
  validates_format_of :contact_phone, :allow_blank => true,
    :with => /((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}*/
  validates_format_of :zip_code, :allow_blank => true,
    :with => /^\d{5}$|^\d{5}-\d{4}$*/
  validates_format_of :covered_entity_zip_code, :allow_blank => true,
    :with => /^\d{5}$|^\d{5}-\d{4}$*/
end