class CreateShoppingList < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_list do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :notes
    end
  end
end
