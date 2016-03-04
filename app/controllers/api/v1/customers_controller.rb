class Api::V1::CustomersController < ApplicationController
 before_action :set_customer, only: [:show, :update, :destroy]

  def index
    @user = current_user
    @customers = @user.customers.all
    render json: @customers
  end

  def show
    @customer = Customer.find(params[:id])
    render json: @customer
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      head :no_content
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    head :no_content
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:full_name, :email, :phone)
    end
end
