class AddNotesToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :notes, :string
  end
end
