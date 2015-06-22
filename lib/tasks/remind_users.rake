desc "This is the reminder to send users an email."
task :remind_users => :environment do 
	Contact.all.each do |contact| 
		ContactMailer.reminder_email(contact).deliver_now
	end

end