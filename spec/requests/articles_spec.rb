require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe "Articles", type: :request do
  before do
    @user = User.create(email: 'user@example.com', password: 'password')
    @user2 = User.create(email: 'user2@example.com', password: 'password')
    @article = Article.create!(title: 'Title One', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequatur fugit impedit inventore, laudantium neque nihil porro ut! Aliquam blanditiis, commodi earum est facere ipsam magni maxime, nihil quod rem sint?', user: @user)
  end

  describe "PATCH /articles/:id/edit" do
    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit" }

      it 'redirects to the sign in page' do
        expect(response).to have_http_status(302)
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        sign_in @user2
        get "/articles/#{@article.id}/edit"
      end

      it 'redirects to the home page' do
        expect(response).to have_http_status(302)
        flash_message = "You can only edit your own article."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is owner' do
      before do
        sign_in @user
        get "/articles/#{@article.id}/edit"
      end

      it 'successfully edit article' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /articles/:id" do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it 'handles existing article' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxxx" }

      it 'handles non-existing article' do
        expect(response).to have_http_status(302)
        flash_message = 'The article you are looking for could not be found'
        expect(flash[:alert]).to eq(flash_message)
      end
    end
  end

  describe "DELETE /articles/:id" do
    context 'with non-signed in user' do
      before { delete "/articles/#{@article.id}" }

      it 'redirects to the sign in page' do
        expect(response).to have_http_status(302)
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        sign_in @user2
        delete "/articles/#{@article.id}"
      end

      it 'redirects to the home page' do
        expect(response).to have_http_status(302)
        flash_message = "You can only destroy your own article."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is owner' do
      before do
        sign_in @user
        delete "/articles/#{@article.id}"
      end

      it 'successfully destroy article' do
        expect(response).to have_http_status(302)
        flash_message = "Article has been deleted"
        expect(flash[:notice]).to eq flash_message
      end
    end
  end

end
