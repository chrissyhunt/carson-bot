class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :user_id
      t.integer :location_id
      t.integer :type_id
      t.boolean :perishable
      t.string :condition_status
      t.string :condition_notes
      t.string :registration_code
      t.float :value
      t.string :size
      t.string :weight
      t.date :date_acquired
      t.string :source
    end
  end
end
