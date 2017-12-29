class ShoppingList < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :types, through: :items
end
