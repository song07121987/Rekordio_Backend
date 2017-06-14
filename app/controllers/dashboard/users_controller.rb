class Dashboard::UsersController < DashboardController

	def index
		p "dashboard users index ---------------------------------"

		@users = User.all

		@users = @users.map{|user| user.user_info_detail}

		@breadcrumbs = [
    	{label: "DASHBOARD", url: dashboard_path},
    	{label: "USERS", url: dashboard_users_path}
    ]

	end

end