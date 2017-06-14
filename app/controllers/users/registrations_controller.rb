class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
# before_action :configure_sign_up_params, only: [:create]
  skip_before_action :verify_authenticity_token, only: :create
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    p "-----------------user signup--------------"
    user = User.new(user_params)
    user.skip_confirmation!
    if user.save
      data = { success: true, message: "Your account registered." }
    else
      key, val = user.errors.messages.first
      data = { success: false, message: user.errors.full_messages.first }
    end
    render json: data
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  # Private methods
  #----------------------------------------------------------------------
  private

  def user_params
    p "-------user_params-------------"
    # if action_name == "create"
      # params[:user][:first_name] = params[:user][:first_name]
      # params[:user][:last_name] = params[:user][:last_name]
    # end
    # params[:user][:phone] = nil unless params[:user][:phone].present?
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
