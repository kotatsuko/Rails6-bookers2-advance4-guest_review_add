class AddColumnToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :star, :float, null: false, default: 1
  end
end
