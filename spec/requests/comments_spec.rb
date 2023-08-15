require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe "Comments", type: :request do
  before do
    @user = User.create(email: 'user@example.com', password: 'password')
    @user2 = User.create(email: 'user2@example.com', password: 'password')
    @article = Article.create(title: 'articulo 1', body: 'body 1', user: @user)
  end

  describe "POST /articles/:id/comments" do
    context 'with a non-signed in user' do
      before { post "/articles/#{@article.id}/comments", params: { comment: { body: 'Awesome blog' } }, as: :json }

      it 'redirect user to the sign in page' do
        flash_message = 'Please sign in or sing up first'
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with a signed in user' do
      before do
        sign_in @user2
        post "/articles/#{@article.id}/comments", params: { comment: { body: 'Awesome blog' } }, as: :json
      end

      it 'create the comment successfully' do
        flash_message = 'Comment has been created'
        expect(response).to redirect_to(article_path(@article.id))
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq flash_message
      end
    end
  end
end
