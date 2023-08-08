require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe 'Listing Articles', type: :feature do
  before do
    @article1 = Article.create(title: 'articulo 1', body: 'body 1')
    @article2 = Article.create(title: 'articulo 2', body: 'body 2')
  end

  scenario "A user list all articles" do
    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end
end