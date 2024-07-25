class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.references :test, null: false, foreign_key: true
      t.string :content
      t.string :correct_answer

      t.timestamps
    end
  end
end
