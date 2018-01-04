class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :location
  has_many :list_items
  has_many :lists, through: :list_items

  def expired?
    !!self.expiration_date && self.expiration_date < Time.now
  end

end
