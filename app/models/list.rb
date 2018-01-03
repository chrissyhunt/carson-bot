class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_items
  has_many :items, through: :list_items
  has_many :categories, through: :items
end
