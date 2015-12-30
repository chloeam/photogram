class CommentsController < ApplicationControllerj

  before_action :set_post

  def destroy
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    flash[:success] = "Your comment has been deleted."
    redirect_to root_path
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "Your comment was saved!"
      redirect_to :back
    else
      flash[:alert] = "Something went wrong. Check the comment form."
      render root_path
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

end