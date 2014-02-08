class AddFieldsToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :detail, :string
    add_column :microposts, :desire, :integer
  end
end
