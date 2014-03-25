class AddPurchaseId < ActiveRecord::Migration
  def change
    add_column :cashiers, :purchase_id, :integer
  end
end
