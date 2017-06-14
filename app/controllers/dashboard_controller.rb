class DashboardController < ApplicationController
	before_action :authenticate_user!
  before_action :authenticate_verify_user

	# General actions
  #----------------------------------------------------------------------
  # GET   /dashboard(.:format)
  def index

  	p "dashboard index ---------------------------------"

    # respond_to do |format|
    #   format.html{ render layout: params[:type] != "ajax" }
    #   format.json{ render json: UserDatatable.new(view_context) }
    # end
    redirect_to dashboard_path

    @breadcrumbs = [
    	{label: "DASHBOARD", url: dashboard_path}
    ]

  end

end
