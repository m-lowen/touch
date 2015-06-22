class RemoveRemindersFromContacts < ActiveRecord::Migration
  def change
  	remove_column :contacts, :reminder
  end
end
