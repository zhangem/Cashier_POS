class AddedThingToDoTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :name, :string
  end
end
