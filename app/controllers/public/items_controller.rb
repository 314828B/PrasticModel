class Public::ItemsController < ApplicationController
  def index
    #byebug
    @items = Item.all.page(params[:page]).per(8)
    @item_amount = Item.count
    @item = Item.new
    @customer = current_customer
    @genres = Genre.all
    @genre = 0
  end

  def show
    @item = Item.find(params[:id])
    @newitem = Item.new
    @customer = @item.customer
    @comment = Comment.new
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  def edit
    @item = Item.find(params[:id])
    @customer = @item.customer
     if current_customer.id != @customer.id
      redirect_to items_path
     end
  end

  def update
    @item = Item.find(params[:id])
    if  @item.update(item_params)
        flash[:notice] = "You have updated item successfully."
        redirect_to admin_item_path(@item)
    else
        render :edit
    end
  end

  def new
    @item = Item.new
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    if @item.save
      flash[:notice] = "You have created item successfully."
      redirect_to items_path(@item)
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :introduction, :image, :genre_id)
    end

end
