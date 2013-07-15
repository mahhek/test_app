class CreateClientInterfaces < ActiveRecord::Migration
  def change
    create_table :client_interfaces do |t|
      t.integer :client_id
      t.string :interface_name
      t.string :contact_number
      t.string :interface_connection_type
      
      t.timestamps
    end
  end
end
