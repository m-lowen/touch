module ApplicationHelper
	def current_action?(controller_name, action_name)
		controller.controller_name == controller_name && controller.action_name == action_name
	end

	def resource_name
    	:user
  	end

  	def resource
    	@resource ||= User.new
  	end

  	def devise_mapping
    	@devise_mapping ||= Devise.mappings[:user]
  	end

end
