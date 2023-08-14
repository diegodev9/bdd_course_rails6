class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :check_user, only: %i[edit update destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def show
    @comment = @article.comments.build
    @comments = @article.comments
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to articles_path, notice: "Article has been created"
    else
      flash.now[:alert] = 'Article has not been created'
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article has been updated"
    else
      flash.now[:alert] = 'Article has not been updated'
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article has been deleted'
  end

  protected

  def resource_not_found
    message = 'The article you are looking for could not be found'
    redirect_to root_path, alert: 'The article you are looking for could not be found'
  end

  private

  def check_user
    redirect_to root_path, alert: "You can only #{action_name} your own article." unless @article.user == current_user
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
