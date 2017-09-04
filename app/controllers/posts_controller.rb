class PostsController < ApplicationController

  def index
    @posts = Post.all.page params[:page]
  end

  def show
    @post = Post.find(params[:id])
    @post.visits.create(ip_addr: request.remote_ip)
  end

  def add_rate
    @post = Post.find(params[:id])
    @post.rates.create(value: params[:rate])
    render layout: false
  end

end
