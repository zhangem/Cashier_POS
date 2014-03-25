class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.column :inventory_id, :integer
      t.column :price_id, :integer
    end
  end
end
