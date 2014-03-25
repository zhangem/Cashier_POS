class Order < ActiveRecord::Base
  has_many :inventory
end
