class CreateTests < ActiveRecord::Migration[7.1]
  def change
    create_table :tests do |t|
      t.datetime :scheduled_at
      t.references :part, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
