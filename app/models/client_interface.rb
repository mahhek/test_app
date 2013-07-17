class ClientInterface < ActiveRecord::Base
  attr_accessible :interface_name, :contact_number, :interface_connection_type, :client_id
  belongs_to :client
  validates :contact_number, :format => { :with => /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/ }, :allow_blank => true
end