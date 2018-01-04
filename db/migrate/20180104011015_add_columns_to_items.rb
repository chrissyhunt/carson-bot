class AddColumnsToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :expiration_date, :date
    add_column :items, :info_complete, :boolean
  end
end
