require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe 'Editing an article', type: :feature do
  before do
    @article = Article.create(title: 'Title One', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequatur fugit impedit inventore, laudantium neque nihil porro ut! Aliquam blanditiis, commodi earum est facere ipsam magni maxime, nihil quod rem sint?')
  end

  scenario 'A user deletes an article' do
    visit '/'

    click_link @article.title
    click_link 'Delete Article'

    expect(page).to have_content('Article has been deleted')
    expect(page).to have_current_path(articles_path)
  end
end