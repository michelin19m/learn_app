class AddTitleToTests < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :title, :string
  end
end
