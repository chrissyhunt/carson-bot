class AddAdminColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :admin_lock, :boolean
    add_column :locations, :admin_lock, :boolean
  end
end
