class UsersController < ApplicationController
	
	 before_action :authenticate_user!
   before_action :user_signed_in?

  	def show
   		 @user = current_user
   		 @contact = Contact.new
   		 @contacts = @user.contacts
  	end

end
