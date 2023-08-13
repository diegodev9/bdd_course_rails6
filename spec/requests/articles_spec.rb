require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe "Articles", type: :request do
  before do
    @article = Article.create(title: 'Title One', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequatur fugit impedit inventore, laudantium neque nihil porro ut! Aliquam blanditiis, commodi earum est facere ipsam magni maxime, nihil quod rem sint?')
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

end
