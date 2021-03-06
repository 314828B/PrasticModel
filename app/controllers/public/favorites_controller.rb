class Public::FavoritesController < ApplicationController
  def create
    @item = Item.find(params[:id])
    favorite = current_customer.favorites.new(item_id: @item.id)
    favorite.save
    @customer = current_customer
  end

  def destroy
    @item = Item.find(params[:id])
    favorite = current_customer.favorites.find_by(item_id: @item.id)
      favorite.destroy
        @customer = current_customer
  end

end
