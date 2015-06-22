class AddNameToReminders < ActiveRecord::Migration
  def change
  	add_column :reminders, :name, :string
  end
end
