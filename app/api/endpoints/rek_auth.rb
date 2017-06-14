class Endpoints::RekAuth < Grape::API

	resources :auth do

		desc "Login a user"
    params do
      requires :email, 		          		type: String, desc: "zhon@admin.com"
      requires :password,             	type: String, desc: "User password"
    end
    post :login do
    	user = User.find_by_email(params[:email])

    	if user.present?
    		if user.valid_password?(params[:password])
                user_detail = user.api_detail
    			data = {response: "success", status: "logined", message: "This user logined successfully", user_detail: user_detail}
    		else
    			data = {response: "fail", status: "login_failed", message: "Incorrect Password"}
    		end
    	else
    		data = {response: "fail", status: "login_failed", message: "Incorrect Email"}
    	end
    	data
    end
	end	
end