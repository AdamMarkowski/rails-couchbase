class Comment < ApplicationRecord

  belongs_to :post
  validates :author, :body, presence: true
  after_create :clear_cache

  def clear_cache
    Cache.remove("post:#{post.id}:comments_view")
  end

end
