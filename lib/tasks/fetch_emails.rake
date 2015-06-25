desc "this will pull the emails from our gmail account"
task :fetch_emails => :environment do 


	imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
	if imap.login('networker.app.email', 'waterkant')
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
	subject = ""

	Email.all.each do |e|
		gmail_ids << e.gmail_id
	end


	if message_size == 0
		puts "No new emails!"
	else
		message_ids.each do |message_id|

			envelope = imap.fetch(message_id, "ENVELOPE").first
			binding.pry
			body = imap.fetch(message_id,'BODY[TEXT]').first.attr['BODY[TEXT]']
			File.write('lib/assets/email.eml', body)
			body = Mail.read('lib/assets/email.eml')
			body = body.body.decoded
			# Might be able to split on the first --, check more cases.
			body = body.split(/--/).first

		

			username = envelope.attr["ENVELOPE"].from[0].mailbox
			domain = envelope.attr["ENVELOPE"].from[0].host
			gmail_id = envelope.attr["ENVELOPE"].message_id

			user_email = "#{username}@#{domain}"
			date = envelope.attr["ENVELOPE"].date
			subject = envelope.attr["ENVELOPE"].subject
			user = User.find_by_email(user_email)

			puts subject
			puts body

			user &&	user.contacts.each do |c|
				if body.match(/#{c.name}/)
					Email.create(contact_id: c.id, body: body, date: date, gmail_id: gmail_id, subject: subject) unless gmail_ids.include? gmail_id
				end
			end
		end
	end

end
