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

  scenario "A user has no articles" do
    Article.destroy_all

    visit '/'

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end
  end
end