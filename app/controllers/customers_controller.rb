class CustomersController < ApplicationController
  before_filter :set_customer, only: [:show, :edit, :destroy, :update]

  authorize_resource

  def index
    @customers = Customer.all.page params[:page]
  end

  def new
    @customer = Customer.new
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update_attributes(customer_params)
      flash[:success] = "Customer updated!"
      redirect_to @customer
    else
      render 'edit'
    end
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:notice] = "Customer created!"
      redirect_to @customer
    else
      flash[:notice] = "Customer not created!"
      render 'new'
    end
  end

  def destroy
    if @customer.destroy
      return render :json => { :success => true }
    else
      return render :json => { :success => false }
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :email, :phone,
                                     :organization, :address, :province)
  end

  def set_customer
    @customer = Customer.where(id: params[:id]).first
    if not @customer
      flash[:alert] = "Customer not found!"
      redirect_to customers_path
    end
  end
end
