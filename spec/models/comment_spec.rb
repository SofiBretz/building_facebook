# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'associations for 1 post created by a user' do
    before :example do
      @user = User.create(first_name: 'test', last_name: 'test', email: 'test@test.com', password: '123456')

      @post = Post.create!(content: 'This is the content of post 1', user_id: @user.id)

      @comment = Comment.create!(content: 'This is the content of comment 1', post_id: @post.id, user_id: @user.id)
    end

    it 'the comment can access to the creator' do
      expect(@comment.user).to eq(@user)
    end

    it 'the comment can access to the post' do
      expect(@comment.post).to eq(@post)
    end
  end

  context 'validations for a new comment' do
    before :example do
      @user = User.create(first_name: 'test', last_name: 'test', email: 'test@test.com', password: '123456')

      @post = Post.create!(content: 'This is the content of post 1', user_id: @user.id)

      @comment = Comment.new(content: 'This is the content of comment 1', post_id: @post.id, user_id: @user.id)
    end

    it 'checks that comment must be valid' do
      expect(@comment.valid?).to eq(true)
    end

    it 'checks that content must be present' do
      @comment.content = ''
      expect(@comment.valid?).to eq(false)
    end
  end
end
