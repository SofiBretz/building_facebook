# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Friendships', type: :feature do
  context '2 users are not friends' do
    before :example do
      @user1 = User.create(first_name: 'test1', last_name: 'test1', email: 'test1@test.com', password: '123456')
      @user2 = User.create(first_name: 'test2', last_name: 'test2', email: 'test2@test.com', password: '123456')

      sign_in @user1
    end

    it 'user can accept the friend request' do
      @user2.send_friend_request(@user1)
      @user1.reload
      visit(friendships_path)
      expect do
        click_link 'Accept Friend Request'
        @user1.reload
      end .to change { @user1.friends.count }.by(1)
    end
  end
end
