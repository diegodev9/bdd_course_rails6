require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe 'Showing an article', type: :feature do
  before do
    @article1 = Article.create(title: 'articulo 1', body: 'body 1')
  end

  scenario 'A user shows an article' do
    visit '/'
    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))
  end
end