require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Listing Articles', type: :feature do
  before do
    @user = User.create(email: 'user@example.com', password: 'password')
    # sign_in @user

    @article1 = Article.create(title: 'articulo 1', body: 'body 1', user: @user)
    @article2 = Article.create(title: 'articulo 2', body: 'body 2', user: @user)
  end

  scenario "with articles created and user not signed in" do
    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link('New Article')
  end

  scenario "with articles created and user signed in" do
    sign_in @user
    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link('New Article')
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