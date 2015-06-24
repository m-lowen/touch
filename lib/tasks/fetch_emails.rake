desc "this will pull the emails from our gmail account"
task :fetch_emails => :environment do 


	imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
	if imap.login('touchtesting1', 'waterkant')
		puts true
	end

	imap.select("[Gmail]/All Mail")
	message_ids = imap.search(["NOT","NEW"])
	message_size = message_ids.size
	count = 0
	user_email = ""
	body = ""
	date = ""

	while message_size > count

		if message_size > 0
		
			envelope = imap.fetch(message_ids[0], "ENVELOPE")
			body = imap.fetch(message_ids[count],'BODY[TEXT]')[0].attr['BODY[TEXT]']
			envelope.each do |email|
				u = email.attr["ENVELOPE"].from[0].mailbox
				d = email.attr["ENVELOPE"].from[0].host
				user_email = "#{u}@#{d}"
				date = email.attr["ENVELOPE"].date
			end
			

			user = User.find_by_email(user_email)
			contacts_size = user.contacts.size

			user.contacts.each do |c|
				if !(body.match(/#{c.name}/).nil?)
					email = Email.create(contact_id: c.id, body: body, date: date)
					contact_id = c.id 
					puts email
				end
				# puts contact_id
			end

		


		else puts "sorry nothing new"
		end

		count = count + 1
		
	end 

end
