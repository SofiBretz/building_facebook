# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    current_user.send_friend_request(user) if user

    redirect_back(fallback_location: root_path)
  end

  def update
    user = User.find(params[:id])
    current_user.confirm_friend(user) if user

    redirect_back(fallback_location: root_path)
  end

  def index
    @friend_requests = current_user.friend_requests
  end
end
