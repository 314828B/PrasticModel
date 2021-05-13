class Public::CommentsController < ApplicationController
  def create
    item = Item.find(params[:item_id])

      comment = current_customer.comments.new(comment_params)
      comment.item_id = item.id
      comment.save
      @item = Item.find(params[:item_id])
  end

  def destroy
    comment = Comment.find_by(id: params[:id], item_id: params[:item_id])
    comment.destroy
    @item = Item.find(params[:item_id])
  end

  private

  def book_comment_params
    params.require(:comments).permit(:comment)
  end
end
