class AddEmailIdFromGmail < ActiveRecord::Migration
  def change
  	add_column :emails, :gmail_id, :string
  end
end
