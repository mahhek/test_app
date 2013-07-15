class ClientContact < ActiveRecord::Base
  attr_accessible :company, :name, :title, :phone, :email, :participate_in, :client_id
  belongs_to :client
  validates_format_of :phone, :allow_blank => true,
    :with => /((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}*/
end
