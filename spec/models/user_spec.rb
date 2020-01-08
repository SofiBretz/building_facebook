# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.create(first_name: 'test', last_name: 'test', email: 'test@test.com', password: '123456')
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  context 'Name validation' do
    it 'Valid name check' do
      expect(@user).to be_valid
    end

    it 'Invalid name check ' do
      @user.first_name = ''
      expect(@user).to_not be_valid
    end
  end

  context 'Email validation' do
    it 'Valid email check' do
      expect(@user).to be_valid
    end

    it 'Invalid email check' do
      @user.email = 'xxx'
      expect(@user).to_not be_valid
    end
  end

  context 'user and friendship'  do
    before :example do
      @user1 = User.create(first_name: 'test1', last_name: 'test1', email: 'test1@test.com', password: '123456')
      @user2 = User.create(first_name: 'test2', last_name: 'test2', email: 'test2@test.com', password: '123456')
      @user3 = User.create(first_name: 'test3', last_name: 'test3', email: 'test3@test.com', password: '123456')

    end
    it 'user can send many friend request' do
      @user1.send_friend_request(@user2)
      @user1.send_friend_request(@user3)
      expect(@user1.sent_requests.count).to eq(2)
    end

    it 'user can receive many friend request' do
      @user2.send_friend_request(@user1)
      @user3.send_friend_request(@user1)
      expect(@user1.received_requests.count).to eq(2)
    end

    it '2 users can be friend only if the request is accepted' do
      @user1.send_friend_request(@user2)
      expect{@user2.confirm_friend(@user1)
      @user1.reload}.to change{@user1.friends.count}.by(1)
    end
  end
end
