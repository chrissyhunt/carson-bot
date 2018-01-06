class RemoveColumnsFromItemsListItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :info_complete
    remove_column :list_items, :notes
  end
end
