class ClientInterface < ActiveRecord::Base
  attr_accessible :interface_name, :contact_number, :interface_connection_type, :client_id
  belongs_to :client
  validates_format_of :contact_number, :allow_blank => true,
    :with => /((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}*/
end
