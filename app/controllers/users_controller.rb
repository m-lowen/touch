class UsersController < ApplicationController
	
	 before_action :authenticate_user!

  	def show
   		 @user = current_user
   		 @contact = Contact.new
   		 @contacts = @user.contacts
  	end

end
