class AddInterestedPostsToUser < ActiveRecord::Migration
  def change
    add_column :users, :interested_posts, :string
  end
end
