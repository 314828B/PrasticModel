class Public::SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]
  if @range == '1'
    @customer = Customer.search(search,word)
    render 'public/searches/search'
  else
    @item = Item.search(search,word)
    render 'public/searches/search'
  end
  end
  
  def genre_search
    @genre = Genre.find(params[:genre_id])
    @items = @genre.items.page(params[:page]).per(8)
    @item_amount = @items.count
    @genres = Genre.all
    render 'public/searches/genru_search'
    @customer = current_customer
    @items = Item.all.page(params[:page]).per(8)
    @item_amount = Item.count
    @item = Item.new
    @customer = current_customer
    @genre = 0
  end
  
end
