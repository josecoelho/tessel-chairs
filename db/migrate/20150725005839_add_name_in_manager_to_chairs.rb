class AddNameInManagerToChairs < ActiveRecord::Migration
  def change
    add_column :chairs, :name_in_manager, :string
    add_index :chairs, [:chairs_manager_id, :name_in_manager]
  end
end
