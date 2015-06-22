class Reminder < ActiveRecord::Base
	belongs_to :contact

	REMINDERS = ['1 week', '1 month', '3 months']
end
