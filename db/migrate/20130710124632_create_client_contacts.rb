class CreateClientContacts < ActiveRecord::Migration
  def change
    create_table :client_contacts do |t|
      t.integer :client_id
      t.string :company
      t.string :name
      t.string :title
      t.string :phone
      t.string :email
      t.string :participate_in
      
      t.timestamps
    end
  end
end
