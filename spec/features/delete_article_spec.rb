require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Deleting an article', type: :feature do
  before do
    @article = Article.create(title: 'Title One', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequatur fugit impedit inventore, laudantium neque nihil porro ut! Aliquam blanditiis, commodi earum est facere ipsam magni maxime, nihil quod rem sint?')
    @user = User.create(email: 'user@example.com', password: 'password')
    sign_in @user
  end

  scenario 'A user deletes an article' do
    visit '/'

    click_link @article.title
    click_link 'Delete Article'

    expect(page).to have_content('Article has been deleted')
    expect(page).to have_current_path(articles_path)
  end
end