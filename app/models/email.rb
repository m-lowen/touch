class Email < ActiveRecord::Base
	belongs_to :contact

	# require 'net/imap'
	# require 'gmail_xoauth'

	# attr_accessor :email, :access_token

	# def initialize(args)
	# 	email = args[:email]
	# 	access_token = args[:access_token]
	# end

	# def xoauth_imap_authorize
	# 	imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
	# 	imap.authenticate('XOAUTH2', @email, @access_token)
	# 	imap.select("[Gmail]/All Mail")
	# 	imap
	# end
	

end
