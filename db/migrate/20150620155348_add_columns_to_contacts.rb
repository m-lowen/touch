class AddColumnsToContacts < ActiveRecord::Migration
  def change
  	add_column :contacts, :name, :string
  	add_column :contacts, :email, :string
  	add_column :contacts, :user_id, :integer
  	add_column :contacts, :company, :string 
  	add_column :contacts, :last_contact, :datetime
  	add_column :contacts, :notes, :text 
  	
  end
end
