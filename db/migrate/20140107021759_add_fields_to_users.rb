class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_checked, :date
  end
end
