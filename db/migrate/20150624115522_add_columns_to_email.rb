class AddColumnsToEmail < ActiveRecord::Migration
  def change
  	add_column :emails, :contact_id, :integer
  	add_column :emails, :body, :text
  	add_column :emails, :date, :datetime
  end
end
