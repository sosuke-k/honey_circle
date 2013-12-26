class AddStaredPostsToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :stared_posts, :string
  end
end
