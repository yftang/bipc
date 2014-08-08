class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:success] = "Customer created"
    else
      render 'new'
    end
  end

  def destroy
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :email, :tel,
                                     :ins, :add, :city)
  end
end
