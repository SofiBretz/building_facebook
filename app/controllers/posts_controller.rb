# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def destroy; end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
    else
      flash.now[:error] = 'Error! Please type your post and try again'
      redirect_to new_post_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
