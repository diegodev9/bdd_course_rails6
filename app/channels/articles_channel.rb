class ArticlesChannel < ApplicationCable::Channel
  def subscribed
    article = Article.find(params[:id])
    stream_for article
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
