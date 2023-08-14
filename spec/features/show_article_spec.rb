require 'rails_helper'
require 'support/database_cleaner'
require 'support/devise'

RSpec.describe 'Showing an article', type: :feature do
  before do
    @user = User.create(email: 'user@example.com', password: 'password')
    @user2 = User.create(email: 'user2@example.com', password: 'password')
    @article1 = Article.create(title: 'articulo 1', body: 'body 1', user: @user)
  end

  scenario 'to non-signed in user hide the edit and delete buttons' do
    visit '/'
    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))
    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end

  scenario 'to non-owner hide the edit and delete buttons' do
    visit '/'
    sign_in @user2
    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))
    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end

  scenario 'a signed in owner sees the edit and delete buttons' do
    visit '/'
    sign_in @user
    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))
    expect(page).to have_link('Edit Article')
    expect(page).to have_link('Delete Article')
  end
end