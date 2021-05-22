class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    if @customer.save
      flash[:notice] = "You have updted customer successfully."
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end

    private
  def customer_params
    params.require(:customer).permit(:name,:kana_name,:email,:is_deleted)
  end
end
