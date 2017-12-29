class User < ActiveRecord::Base
  has_secure_password
  has_many :items
  has_many :locations
  has_many :categories, through: :items
  has_many :shopping_lists
end
