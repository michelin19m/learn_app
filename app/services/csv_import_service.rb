class CsvImportService
  def initialize(csv_content, part, user)
    @csv_content = csv_content
    @part = part
    @user = user
  end

  def call
    return { success: false, message: 'No CSV content provided.' } if @csv_content.blank?

    questions_and_answers = parse_csv
    return { success: false, message: 'The CSV content is empty or improperly formatted.' } if questions_and_answers.empty?

    test = create_test(questions_and_answers)
    { success: true, test: test }
  end

  private

  def parse_csv
    questions_and_answers = []
    CSV.parse(@csv_content, headers: true) do |row|
      if row['question'].present? && row['answer1'].present? && row['answer2'].present? && row['answer3'].present? && row['answer4'].present? && row['correct_answer'].present?
        answers = [row['answer1'], row['answer2'], row['answer3'], row['answer4']]
        if answers.length == 4
          questions_and_answers << {
            question: row['question'],
            answer_options: answers,
            correct_answer: row['correct_answer']
          }
        end
      end
    end
    questions_and_answers
  end

  def create_test(questions_and_answers)
    binding.pry
    test = @part.tests.create!(title: 'Generated Test', user: @user)
    questions_and_answers.each do |qa|
      test.questions.create!(
        content: qa[:question],
        correct_answer: qa[:correct_answer],
        answer_options: qa[:answer_options]
      )
    end
    test
  end
end
