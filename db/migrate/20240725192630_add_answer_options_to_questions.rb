class AddAnswerOptionsToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :answer_options, :text, array: true, default: []
  end
end
