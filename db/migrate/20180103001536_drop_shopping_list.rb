class DropShoppingList < ActiveRecord::Migration[5.1]
  def change
    drop_table :shopping_list
  end
end
