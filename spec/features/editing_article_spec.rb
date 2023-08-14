require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Editing an article', type: :feature do
  before do
    @article = Article.create(title: 'Title One', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequatur fugit impedit inventore, laudantium neque nihil porro ut! Aliquam blanditiis, commodi earum est facere ipsam magni maxime, nihil quod rem sint?')
    @user = User.create(email: 'user@example.com', password: 'password')
    sign_in @user
  end

  scenario 'A user updates an article' do
    visit '/'

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'article_title', with: 'Updated Title'
    fill_in 'article_body', with: 'Updated Body of Article'
    click_button 'Update Article'

    expect(page).to have_content('Article has been updated')
    expect(page).to have_current_path(article_path(@article))
  end

  scenario 'A user fails to update an article' do
    visit '/'

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'article_title', with: ''
    fill_in 'article_body', with: 'Updated Body of Article'
    click_button 'Update Article'

    expect(page).to have_content('Article has not been updated')
    expect(page).to have_current_path(article_path(@article))
  end
end