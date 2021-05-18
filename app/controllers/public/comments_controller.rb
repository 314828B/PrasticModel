class Public::CommentsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
      comment = current_customer.comments.new(comment_params)
      comment.item_id = item.id
      comment.save
      redirect_to item_path(item)
  end

  def destroy
    comment = Comment.find_by(id: params[:id], item_id: params[:item_id])
    comment.destroy
    @item = Item.find(params[:item_id])
    redirect_to item_path(@item)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :rate)
  end
end
