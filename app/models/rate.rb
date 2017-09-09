class Rate < ApplicationRecord

  belongs_to :post, optional: true

  validates_inclusion_of :value, in: 1..5

  after_create do
    Cache.remove("post:#{post.id}:rating_helper")
  end

end
