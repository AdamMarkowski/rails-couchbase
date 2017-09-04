class Rate < ApplicationRecord

  belongs_to :post, optional: true

  validates_inclusion_of :value, in: 1..5

end
