class RemoveLastCheckedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :last_checked, :date
  end
end
