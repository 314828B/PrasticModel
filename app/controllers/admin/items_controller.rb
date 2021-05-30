class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
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

  def show
    @item = Item.find(params[:id])
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
  
  def destroy
    @item.destroy
    redirect_to admin_item_path
  end

  private

  def item_params
   params.require(:item).permit(:image, :name, :introduction, :genre_id, :image)
  end

end
