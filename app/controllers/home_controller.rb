class HomeController < ApplicationController
	before_filter :authenticate_admin
	
	def index
		p "----------------------HomeController : index --------------------"
		p request.original_url

		if current_user.present?
	      user = current_user
	      flash[:error] = nil

	      redirect_to dashboard_path
	    else
	      sign_out(:user)
	    end
	end
end
