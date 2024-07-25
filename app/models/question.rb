class Question < ApplicationRecord
  belongs_to :test

  validates :content, presence: true
  validates :correct_answer, presence: true
  validates :answer_options, presence: true

  # Ensuring answer_options is stored as an array
  # serialize :answer_options, coder: JSON
end
