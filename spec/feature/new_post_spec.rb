# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User Creates New Post', type: :feature do
  before :each do
    @user = User.create(first_name: 'test', last_name: 'test', email: 'test@test.com', password: '123456')

    visit new_user_session_path
    fill_in('Email', with: @user.email)
    fill_in('Password', with: @user.password)
    within '.actions' do
      click_button('Log in')
    end
  end

  scenario 'Valid Post' do
    fill_in('post[content]', with: 'Hello World')
    click_button('Post')
    expect(page).to have_current_path(root_path)
  end

  scenario 'Invalid Post(content length)' do
    click_button('Post')
    expect(page).to have_current_path(new_post_path)
  end
end
