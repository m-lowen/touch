class Contact < ActiveRecord::Base
	belongs_to :user

	validates(:name, :presence => true)

	REMINDERS = ['1 week', '1 month', '3 months']
	
  end
