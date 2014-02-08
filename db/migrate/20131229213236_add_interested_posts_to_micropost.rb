class AddInterestedPostsToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :interested_posts, :string
  end
end
