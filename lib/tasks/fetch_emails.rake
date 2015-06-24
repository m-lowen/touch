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
	gmail_ids =[]

	Email.all.each do |e|
		gmail_ids << e.gmail_id
	end


	if message_size == 0
		puts "No new emails!"
	else
		message_ids.each do |message_id|

			envelope = imap.fetch(message_id, "ENVELOPE").first
			x=0
			body = imap.fetch(message_id,'BODY[TEXT]').first.attr['BODY[TEXT]']
			File.write('lib/assets/email.eml', body)
			body = Mail.read('lib/assets/email.eml')
	
			body = body.body.decoded
			body = body.split(/--001/).first
			puts body

			username = envelope.attr["ENVELOPE"].from[0].mailbox
			domain = envelope.attr["ENVELOPE"].from[0].host
			gmail_id = envelope.attr["ENVELOPE"].message_id

			user_email = "#{username}@#{domain}"
			date = envelope.attr["ENVELOPE"].date
			x=x+1
			user = User.find_by_email(user_email)
			contacts_size = user.contacts.size

			if !(user.nil?)
				user.contacts.each do |c|
			
					if body.match(/#{c.name}/)
						Email.create(contact_id: c.id, body: body, date: date, gmail_id: gmail_id) unless gmail_ids.include? gmail_id
					end
				end
			end
		end
	end

end
