# frozen_string_literal: true

module FriendshipsHelper
  def friend_status(user)
    return unless current_user != user

    if current_user.friend? user
      'Friends'
    elsif current_user.pending_friends.include? user
      'Waiting for Comfirmation'
    elsif current_user.friend_requests.include? user
      link_to 'Accept Friend Request', friendship_path(user), method: :patch
    else
      link_to 'Send Friend Request', friendships_path(user), method: :post
    end
  end
end
