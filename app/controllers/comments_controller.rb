class CommentsController < ApplicationController
  before_action :set_article

  def create
    unless current_user
    redirect_to new_user_session_path, alert: 'Please sign in or sing up first'
    else
      @comment = @article.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        redirect_to article_path(@article), notice: 'Comment has been created'
      else
        redirect_to article_path(@article), alert: 'Comment has not been created'
      end
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
