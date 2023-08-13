class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:alert] = 'Article has not been created'
      render :new
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
