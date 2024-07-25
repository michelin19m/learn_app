class Resource < ApplicationRecord
  belongs_to :skill
  has_many :parts, dependent: :destroy
end
