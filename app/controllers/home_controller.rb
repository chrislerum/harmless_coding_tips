class HomeController < ApplicationController
  def index
    @posts = Post.all.where(published: true)
  end

  def show_post
    @post = Post.friendly.find(params[:id])
  end

  def unpublished
    @posts = Post.all.where(published: false)
  end
end
