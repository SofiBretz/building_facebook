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
end
