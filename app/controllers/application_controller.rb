class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception

  before_filter :after_token_authentication 

  def after_token_authentication
    if params[:authentication_key].present?
      @user = User.find_by_authentication_token(params[:authentication_key]) 
      sign_in @user if @user 
      redirect_to customers_path 
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :email, :password, :password_confirmation, :authentication_token) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :current_password, :authentication_token) }
    end
end
