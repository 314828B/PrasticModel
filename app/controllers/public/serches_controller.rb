class Public::SerchesController < ApplicationController
  def search
    @genre = Genre.find(params[:genre_id])
    @items = @genre.items.page(params[:page]).per(8)
    @item_amount = @items.count
    @genres = Genre.all
    render 'items/index'
  end
end
