class Endpoints::RekUsers < Grape::API
	
	resources :users do
  	
  	desc "Test user endpoints"
  	post :test  do
  		data = {data: params}
  		data
  	end

  	desc "Registers a user"
    params do
      requires :email,           				type: String, desc: "zhon@admin.com"
      requires :last_name,            	type: String, desc: "Last name"
      requires :first_name,           	type: String, desc: "First name"
      requires :password,             	type: String, desc: "User password"
      requires :user_role,             	type: String, desc: "User Role"
    end
    post :register do
	    # user = User.where(first_name: params[:first_name], last_name: params[:last_name], specialty: params[:specialty]).first
	    user = User.where(email: params[:email]).first
	    if user.present?
	    	data = {response: "fail", status: "duplicated", message: "This user already registered."}
	    else
	    	user = User.new(
	    		first_name: 							params[:first_name], 
	    		last_name: 								params[:last_name],
	    		email: 										params[:email],
	    		password: 								params[:password],
	    		password_confirmation: 		params[:password],
	    		user_role: 								params[:user_role]
	    		)
	    	
	    	user.skip_confirmation!

	    	if user.save
		      data = {response: "success", status: "registered", message: "This user registered successfully."}
		    else
		      key, val = user.errors.messages.first
		      data = {response: "fail", status: key, message: user.errors.full_messages.first}
		    end
	    end
	    data
    end
  end
end