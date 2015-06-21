class UsersController < ApplicationController
	
	 before_action :authenticate_user!

  	def show
   		 @user = User.find(params[:id])
   		# @tweets = @user.tweets
  	end

 	def index
   		 @users = User.all
 	end

end
