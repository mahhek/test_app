class ClientContact < ActiveRecord::Base
  attr_accessible :company, :name, :title, :phone, :email, :participate_in, :client_id
  belongs_to :client
  validates :phone, :format => { :with => /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/ }, :allow_blank => true
end
