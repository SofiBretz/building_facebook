# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

 validates :email, presence: true, length: { maximum: 255 },
                   format: { with: VALID_EMAIL_REGEX },
                   uniqueness: { case_sensitive: false }
 validates :name, presence: true, length: { maximum: 50 }
 validates :password, presence: true, length: { maximum: 10 }
 validates :password_confirmation, presence: true, length: { maximum: 10 }
end
