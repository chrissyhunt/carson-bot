class User < ActiveRecord::Base
  has_secure_password
  has_many :items
  has_many :locations
  has_many :types, through: :items
  has_many :shopping_lists
end
