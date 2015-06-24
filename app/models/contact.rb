class Contact < ActiveRecord::Base
	has_many :reminders
	belongs_to :user

	validates(:name, :presence => true)

	
  end
