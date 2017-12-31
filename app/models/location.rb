class Location < ActiveRecord::Base
  has_many :items
  has_many :categories, through: :items
  belongs_to :user
end
