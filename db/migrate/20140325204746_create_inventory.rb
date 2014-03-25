class CreateInventory < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.column :name, :string
      t.column :price, :float
      t.column :quanity, :integer
      t.timestamps
    end
  end
end
