class CommentsController < ApplicationController
  before_action :set_article

  def create
    if current_user
      @comment = @article.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        ArticlesChannel.broadcast_to(@article, body: @comment.body, user: @comment.user.email)
        flash[:notice] = 'Comment has been created'
      else
        flash[:alert] = 'Comment has not been created'
      end
      redirect_to article_path(@article)
    else
      redirect_to new_user_session_path, alert: 'Please sign in or sing up first'
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
