class CustomersController < ApplicationController

  def index
  end

  def new
  	@customer = Customer.new
  end

  def create
  	@user = current_user
  	@customer = @user.customers.new(params_customer)
  	if @customer.save
  		redirect_to customers_path
  	else
  		render 'new'
  	end
  end

  def refresh_token
  	@user = current_user
  	@user.authentication_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless @user.class.exists?(authentication_token: random_token)
    end
    @user.update(:authentication_token => @user.authentication_token)
    redirect_to customers_path
	end

  private
  	def params_customer
  		params.require(:customer).permit(:full_name, :email, :phone, :user_id)
  	end
end
