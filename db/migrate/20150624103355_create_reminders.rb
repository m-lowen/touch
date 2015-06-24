class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.datetime :date
      t.integer :contact_id

      t.timestamps null: false
    end
  end
end
