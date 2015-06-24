class RemindersController < ApplicationController
	def create
		@reminder = Reminder.new(reminder_params)
		@reminder.save
	end

	private

	def reminder_params
		params["reminder"].permit(:date, :contact_id)
	end
end