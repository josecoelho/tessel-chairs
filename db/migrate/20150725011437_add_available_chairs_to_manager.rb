class AddAvailableChairsToManager < ActiveRecord::Migration
  def change
    add_column :chairs_managers, :available_chairs, :string
  end
end
