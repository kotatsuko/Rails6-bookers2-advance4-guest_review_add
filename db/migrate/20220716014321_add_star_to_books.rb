class AddStarToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :star, :float, null: false, default: 1
  end

  def up
    change_column_default  :books, :star, 0
  end
end
