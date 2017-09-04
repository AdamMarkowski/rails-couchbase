class Post < ApplicationRecord

  belongs_to :author
  has_many :visits
  has_many :rates

end
