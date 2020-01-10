# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes
  has_many :sent_requests, foreign_key: :sender_id, class_name: 'Friendship'
  has_many :received_requests, foreign_key: :receiver_id, class_name: 'Friendship'

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  def already_like?(post)
    Like.exists?(user_id: id, post_id: post.id)
  end

  def like(post)
    return if already_like?(post)

    likes.create(post_id: post.id)
  end

  def unlike(post)
    like = Like.find_by(user_id: id, post_id: post.id)
    like&.destroy
  end

  def friends
    friendships = sent_requests.includes(:receiver).where(confirmed: true).references(:users)
    friendships.map do |f|
    f.receiver
    end
  end

  def pending_friends
    requests = sent_requests.includes(:receiver).where(confirmed: false).references(:users)
    requests.map do |r|
    r.receiver
    end
  end

  def friend_requests
    requests = received_requests.includes(:sender).where(confirmed: false).references(:users)
    requests.map do |r|
    r.sender
    end
  end

  def confirm_friend(user)
    friendship = received_requests.find { |u| u.sender == user }
    friendship.confirmed = true
    friendship.save
  end

  def send_friend_request(user)
    sent_requests.create(receiver_id: user.id)
  end

  def friend?(user)
    friends.include?(user)
  end

  def news_feed
    friend_ids = friends.map(&:id)
    Post.where('user_id IN (?) OR user_id=?', friend_ids, id)
  end
end
