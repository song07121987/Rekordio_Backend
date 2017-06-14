class Users::SessionsController < Devise::SessionsController
  include ApplicationHelper
  # before_action :configure_sign_in_params, only: [:create]
  # skip_before_filter :verify_authenticity_token, :only => :create

  # protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  # GET /resource/sign_in
  def new
    
  end

  # POST /resource/sign_in
  def create
    p "SessionsController - craete------------------start"

    # data = {success: {msg: "User Logined"}}

    p params

    # render :json => {success: true, message: "You logined."}
    # return render :json => {:success => true}
    # respond_to :json

    # user = User.where(email: params[:user][:email].strip).first
    # resource = warden.authenticate!(scope: :user, recall: "#{controller_path}#failure")

    # sign_in_and_redirect(:user, resource)
    

    # p "SessionsController - craete------------------end"

    p params

    email = params[:user][:email]
    password = params[:user][:password]
    user = User.where(email: email).first

    if user.present?
      p "user present------------"
      if user.admin_user?
        p "this user is admin------------------"
        if user.status == 0
          # flash[:error] = "Your account was not verified."
          data = { success: false, message: "Your account was not verified." }
        else
          resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
          sign_in_and_redirect(resource_name, resource) and return
          flash.delete(:error)
        end
      else
        # flash[:error] = "You have no access rights to dashboard."
        data = { success: false, message: "You have no access rights to dashboard." }
      end
    else
      data = {success: false, message: "Can't find account."}
    end

    render json: data
    # p dashboard_path
    # redirect_to dashboard_path
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    p "---------------sign_in_and_redirect"
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    render json: { success: true, message: "You logined." }
  end

  def failure
    render json: { success: false, error: ["Login failed."] }
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end