class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :fname, :lname, :company, :phone, :is_active
  # attr_accessible :title, :body
  validates :fname, :presence => { :message => "can't be blank" }
  validates :lname, :presence => { :message => "can't be blank" }
  validates :phone, :format => { :with => /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/ }, :allow_blank => true
 


 HUMANIZED_ATTRIBUTES = {
:fname => "First Name",
:lname => "Last Name"
}
 def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
end

  belongs_to :client
end
