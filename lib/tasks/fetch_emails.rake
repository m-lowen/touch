desc "this will pull the emails from our gmail account"
task :fetch_emails => :environment do 


	imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
	if imap.login('touchtesting1', 'waterkant')
		puts true
	end
	imap.select("[Gmail]/All Mail")
	message_ids = imap.search("NEW")
	message_size = message_ids.size
	puts message_size

	if message_size > 0
		envelope = imap.fetch(message_ids[0], "ENVELOPE")
		puts envelope

		count = 0
		while message_ids.size > count
			body = imap.fetch(message_ids[count],'BODY[TEXT]')[0].attr['BODY[TEXT]']
			count = count+1
			puts body
		end
	else puts "sorry nothing "
	end


end
