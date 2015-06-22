class HomeController < ApplicationController
  def index
    @posts = Post.all
  end

  def show_post
    @post = Post.friendly.find(params[:id])
  end
end
