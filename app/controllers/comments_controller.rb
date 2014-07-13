class CommentsController < ApplicationController
before_action :authenticate_user!


  def create
    @commentable = commentable
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.commentable = @commentable
    if @comment.save!
      flash.keep[:notice] = "Comment saved!"
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.keep[:notice] = "Comment deleted"
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def commentable
    commentable_type.camelize.constantize.find(commentable_id)
  end

  def commentable_id
    params["#{commentable_type}_id"]
  end

  def commentable_type
    %w(meal dish).detect{ |type| params["#{type}_id"].present? }
  end
end
