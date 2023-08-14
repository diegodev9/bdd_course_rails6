require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Creating Articles', type: :feature do
  before do
    @user = User.create(email: 'user@example.com', password: 'password')
    sign_in @user
  end

  scenario 'A user creates a new article' do
    visit '/' # Visit root page
    click_link 'New Article' # click on new article
    fill_in 'article_title', with: 'Creating a blog' # fill in title
    fill_in 'article_body', with: 'lorem ipsum' # fill in body
    click_button 'Create Article' # create article

    expect(page).to have_content('Article has been created') # article has been created
    expect(page.current_path).to eq(articles_path) # article path
  end

  scenario 'A user fails to create a new article' do
    visit '/' # Visit root page
    click_link 'New Article' # click on new article
    fill_in 'article_title', with: '' # fill in title
    fill_in 'article_body', with: '' # fill in body
    click_button 'Create Article' # create article

    expect(page).to have_content('Article has not been created') # article has not been created
    expect(page).to have_content("Title can't be blank") # article has not been created
    expect(page).to have_content("Body can't be blank") # article has not been created
  end
end