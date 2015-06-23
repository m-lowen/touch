class AddReminderDateToContacts < ActiveRecord::Migration
  def change
  	add_column :contacts, :reminder_date, :datetime
  end
end
