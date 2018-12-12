class AddNumbersToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :likes_numbers, :integer, default: 0
    add_column :posts, :comments_numbers, :integer, default: 0
  end
end
