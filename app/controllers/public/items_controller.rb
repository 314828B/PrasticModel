class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(8)
    @item_amount = Item.count
    @genres = Genre.all
    @genre = 0
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def destroy
  end

  def edit
    @item = Item.find(params[:id])
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
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "You have created item successfully."
      redirect_to admin_item_path(@item)
    else
    # @items = Item.all
     render :new
    end
  end
end
