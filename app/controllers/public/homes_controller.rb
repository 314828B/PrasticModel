class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(id: "DESC").limit(4)
  end
end
