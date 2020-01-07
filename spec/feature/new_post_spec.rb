# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User Creates New Post', type: :feature do
  before :each do
    @user = User.create(first_name: 'test', last_name: 'test', email: 'test@test.com', password: '123456')
    sign_in @user
  end

  scenario 'Valid Post' do
    visit '/posts/new'
    fill_in('post[content]', with: 'Hello World')
    click_button('Create Post')
    expect(page).to have_current_path(root_path)
  end

  scenario 'Invalid Post(content length)' do
    visit '/posts/new'
    click_button('Create Post')
    expect(page).to have_current_path(new_post_path)
  end
end
