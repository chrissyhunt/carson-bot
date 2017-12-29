class Item < ActiveRecord::Base
  belongs_to :users
  belongs_to :type
  belongs_to :location
end
