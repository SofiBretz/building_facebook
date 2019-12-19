class PostsController < ApplicationController
  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def destroy
  end
end
