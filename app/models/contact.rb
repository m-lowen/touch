class Contact < ActiveRecord::Base
	belongs_to :user
	has_many :emails

	validates(:name, :presence => true)

	
  end
