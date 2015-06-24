class Contact < ActiveRecord::Base
	has_many :reminders
	belongs_to :user
	has_many :emails

	validates(:name, :presence => true)

	
  end
