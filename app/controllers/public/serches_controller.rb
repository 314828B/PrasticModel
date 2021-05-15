class Public::SerchesController < ApplicationController
  
  def search
    @genre = Genre.find(params[:genre_id])
    @items = @genre.items.page(params[:page]).per(8)
    @item_amount = @items.count
    @genres = Genre.all
    render 'items/index'
    @range = params[:range]
    search = params[:search]
    word = params[:word]
  if @range == '1'
    @user = User.search(search,word)
  else
    @book = Book.search(search,word)
  end
  end
  
end
