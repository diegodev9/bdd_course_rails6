class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def show
  end

  def create
    @article = Article.new(article_params)
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

  protected

  def resource_not_found
    message = 'The article you are looking for could not be found'
    redirect_to root_path, alert: 'The article you are looking for could not be found'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
