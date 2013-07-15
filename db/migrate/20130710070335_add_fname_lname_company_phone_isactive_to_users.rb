class AddFnameLnameCompanyPhoneIsactiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :company, :string
    add_column :users, :phone, :string
    add_column :users, :is_active, :boolean, :default => true
  end
end