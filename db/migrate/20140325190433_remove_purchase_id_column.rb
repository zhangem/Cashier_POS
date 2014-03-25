class RemovePurchaseIdColumn < ActiveRecord::Migration
  def change
    remove_column :cashiers, :purchase_id, :integer
  end
end
