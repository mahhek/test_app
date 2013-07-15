class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :fname, :lname, :company, :phone, :is_active
  # attr_accessible :title, :body
  validates_presence_of :fname, :lname, :on => :create
  validates_format_of :phone, :allow_blank => true,
  :with => /((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}*/

  belongs_to :client
end
