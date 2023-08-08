require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe 'Creating Articles', type: :feature do
  scenario 'user creates a new article' do
    visit '/' # Visit root page
    click_link 'New Article' # click on new article
    fill_in 'article_title', with: 'Creating a blog' # fill in title
    fill_in 'article_body', with: 'lorem ipsum' # fill in body
    click_button 'Create Article' # create article

    expect(page).to have_content('Article has been created') # article has been created
    expect(page.current_path).to eq(articles_path) # article path
  end
end