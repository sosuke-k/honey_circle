class ModifyCommentOrder < ActiveRecord::Migration
  def change
	Comment.default_scope -> { order('created_at DESC') }
  end
end
