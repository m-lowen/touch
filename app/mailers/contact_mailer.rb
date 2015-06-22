class ContactMailer < ApplicationMailer
	
	def reminder_email(contact)
		@contact = contact
    	@url  = 'http://localhost:3000'
   		mail(to: @contact.user.email, subject: 'A nice reminder')

	end

end
