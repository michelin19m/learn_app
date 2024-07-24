class Part < ApplicationRecord
  belongs_to :resource
  has_many :tests
end
