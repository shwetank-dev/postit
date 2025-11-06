class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])

    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      redirect_to @post, notice: "Comment Created Succesfully"
    else
      @comments = @post.comments.reload
      render 'posts/show', status: :unprocessable_entity
    end
  end

  def vote
    comment = Comment.find(params[:id])
    vote = Vote.new(voteable: comment, creator: current_user, vote: params[:vote])

    if vote.save
      flash[:notice] = 'The vote was saved'
    else
      flash[:error] = 'You can only vote on a comment once'
    end

    redirect_to post_path(comment.post)
  end
end