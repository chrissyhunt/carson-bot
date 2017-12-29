class RenameColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :items, :type_id, :category_id
  end
end
