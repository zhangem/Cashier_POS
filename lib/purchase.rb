class Purchase < ActiveRecord::Base
  belongs_to :cashier
  has_many :inventories
end
