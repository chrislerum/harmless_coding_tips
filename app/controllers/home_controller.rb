class HomeController < ApplicationController
  def index
    @posts = Post.all
  end

  def show_post
    @post = Post.find(params[:id])
  end
end
