class Dashboard::RecordsController < DashboardController

	def index
		p "dashboard records index ---------------------------------"

		@records = Medium.all

		@records = @records.map{|record| record.media_info_detail}

		@breadcrumbs = [
	    	{label: "DASHBOARD", url: dashboard_path},
	    	{label: "RECORDS", url: dashboard_records_path}
	    ]
	end

end