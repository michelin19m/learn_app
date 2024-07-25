class Test < ApplicationRecord
  belongs_to :part
  belongs_to :user
  has_many :questions, dependent: :destroy
end
