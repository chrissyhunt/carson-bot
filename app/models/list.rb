class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_items
  has_many :items, through: :list_items
  has_many :categories, through: :items

  def auto_supported?
    if self.name == "Shopping List" || self.name == "Cleaning List" || self.name == "Incomplete Item Records" || self.name == "Expired Documents"
      return true
    end
  end
end
