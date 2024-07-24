class CreateParts < ActiveRecord::Migration[7.1]
  def change
    create_table :parts do |t|
      t.string :name
      t.references :resource, null: false, foreign_key: true

      t.timestamps
    end
  end
end
