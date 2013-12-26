class AddStaredPostsToUser < ActiveRecord::Migration
  def change
    add_column :users, :stared_posts, :string
  end
end
