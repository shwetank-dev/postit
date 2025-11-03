class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = User.first

    if @comment.save
      redirect_to @post, notice: "Comment Created Succesfully"
    else
      @comments = @post.comments.reload
      render 'posts/show', status: :unprocessable_entity
    end
  end
end