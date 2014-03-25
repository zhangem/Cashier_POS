class DropNamePriceFromPurchases < ActiveRecord::Migration
  def change
    remove_column :purchases, :name, :string
    remove_column :purchases, :price, :float
    add_column :purchases, :inventory_id, :integer
  end
end
