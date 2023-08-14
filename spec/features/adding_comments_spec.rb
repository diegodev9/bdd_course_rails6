require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Adding reviews to articles', type: :feature do
  before do
    @user = User.create(email: 'user@example.com', password: 'password')
    @user2 = User.create(email: 'user2@example.com', password: 'password')
    @article = Article.create(title: 'articulo 1', body: 'body 1', user: @user)
  end

  scenario 'permits a signed in user to write a review' do
    sign_in @user
    visit '/'

    click_link @article.title
    fill_in 'comment_body', with: 'An amazing article'
    click_button 'Add Comment'

    expect(page).to have_content('Comment has been created')
    expect(page).to have_content('An amazing article')
    expect(current_path).to eq(article_path(@article.id))
  end
end