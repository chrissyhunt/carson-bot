class User < ActiveRecord::Base
  has_secure_password
  has_many :items
  has_many :lists
  has_many :locations, through: :items
  has_many :categories, through: :items
  has_many :list_items, through: :items
end
