class AddReminderToContacts < ActiveRecord::Migration
  def change
  	add_column :contacts, :reminder, :string
  end
end
