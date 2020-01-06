# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(first_name: 'test', last_name: 'test', email: 'test@test.com', password: '123456')
    @post = @user.posts.new(content: 'This is a test post')
    @another_user_post = Post.new(content: 'Test Post Two')
  end

  context 'Post Body validation'
  it 'Valid body length check' do
    expect(@post).to be_valid
  end

  it 'Invalid body length check' do
    @post = Post.new(content: 'xxx')
    expect(@post).to_not be_valid
  end

  context 'User-Post Association'
  it 'Checks for User Id' do
    expect(@another_user_post).to_not be_valid
  end
end
