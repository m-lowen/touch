class UsersController < ApplicationController
	
	 before_action :authenticate_user!

  	def show
   		 @user = current_user
   		 @contact = Contact.new
   		 @contacts = @user.contacts
  	end

  	def authenticate_admin!
    if !(user_signed_in? && current_user.admin?)
      flash[:alert] = "You are not authorized to perform this action."

      redirect_to :back
    end
  end

end
