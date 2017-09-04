class Rate < ApplicationRecord

  belongs_to :post

  validates_inclusion_of :rate, in: 1..5

end
