class Post < ApplicationRecord

  paginates_per 10

  belongs_to :author
  has_many :visits
  has_many :rates
  has_many :comments

  def pretty_author
    "#{author.first_name} #{author.second_name}"
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

end
