class Cashier < ActiveRecord::Base
  has_many :purchases
  has_many :inventories
end
