module LikesHelper
  def like_unlike(post)
    if current_user.already_like? post
      link_to 'Unlike', like_path(id: post.id), method: :delete
    else
      link_to 'Like', likes_path(post_id: post.id), method: :post
    end
  end
end
