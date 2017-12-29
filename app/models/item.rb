class Item < ActiveRecord::Base
  belongs_to :users
  belongs_to :category
  belongs_to :location
end
