class Post < ApplicationRecord

  paginates_per 10

  belongs_to :author
  has_many :visits
  has_many :rates
  has_many :comments

  after_update :clear_cache
  after_create :clear_pagination_cache

  default_scope -> { order('updated_at DESC') }

  def pretty_author
    Cache.fetch("post:#{id}:pretty_author") do
      "#{author.first_name} #{author.second_name}"
    end
  end

  def visits_count
    visits.count
  end

  def rating
    rates.average(:value).to_f
  end

  def self.most_popular(limit = 5)
    Post
      .select('posts.*, COUNT(visits.id) as visit_count')
      .joins('LEFT OUTER JOIN visits ON (visits.post_id = posts.id)')
      .group('posts.id')
      .order('visit_count DESC')
      .limit(limit)
  end

  def self.best_rated(limit = 5)
    Post.find_by_sql("
      SELECT AVG(value) AS rate, posts.*
      FROM posts
      LEFT OUTER JOIN rates ON (rates.post_id = posts.id)
      GROUP BY posts.id
      ORDER BY rate DESC
      LIMIT #{limit}
    ")
  end

  def to_s
    title
  end

  def clear_cache
    Cache.remove("post:#{id}")
  end

  def clear_pagination_cache
    pages_count = self.class.count / 10
    (0..pages_count).to_a.each do |i|
      Cache.remove("posts:page:#{i}")
    end
  end

end
