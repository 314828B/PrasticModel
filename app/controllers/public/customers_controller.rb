class Public::CustomersController < ApplicationController
  
  def index
  @customer = @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
    @item = Item.new
    @items = @customer.items
  end

  def edit
    @customer = Customer.find(params[:id])
    #@customer_image = Csutomer.new
    if current_customer.id != @customer.id
      redirect_to customer_path(current_customer)
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if  @customer.update(customer_params)
        flash[:notice] = "You have updated  successfully."
        redirect_to customer_path(@customer)
    else
        render :edit
    end
  end

  def quit
  end


  def withdraw
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。ありがとうございました。またの、ご利用をお持ちしております"
    redirect_to root_path
  end


  private

  def customer_params
	  params.require(:customer).permit(:name, :kana_name, :email, :is_deleted, :image)
  end
end