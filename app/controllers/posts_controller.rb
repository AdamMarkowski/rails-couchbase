class PostsController < ApplicationController

  def index
    @posts = Cache.fetch("posts:page:#{params[:page]}", ttl: 1.hour) do
      posts = Post.all.page(params[:page])
      Kaminari::PaginatableArray.new(
        posts.to_a,
        limit: posts.limit_value,
        offset: posts.offset_value,
        total_count: posts.total_count
      )
    end
  end

  def show
    @post = Cache.fetch("post:#{params[:id]}") { Post.find(params[:id]) }
    @post.visits.create(ip_addr: request.remote_ip)
  end

  def add_rate
    @post = Post.find(params[:id])
    @post.rates.create(value: params[:rate])
    render layout: false
  end

  def add_comment
    @post = Post.find(params[:id])
    @post.comments.create(
      author: params[:author],
      body: params[:body]
    )
    render layout: false
  end

end
