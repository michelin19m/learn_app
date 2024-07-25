class Test < ApplicationRecord
  belongs_to :part
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :attempts, dependent: :destroy

  def parse_csv(csv_content)
    CSV.parse(csv_content, headers: true) do |row|
      question_text = row['question']
      correct_answer = row['correct_answer']
      answers = [row['answer1'], row['answer2'], row['answer3'], row['answer4']]

      questions.create!(
        content: question_text,
        correct_answer: correct_answer,
        answer_options: answers
      )
    end
  end
end
