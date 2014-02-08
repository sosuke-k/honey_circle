class AddLastCheckedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_checked, :datetime
  end
end
