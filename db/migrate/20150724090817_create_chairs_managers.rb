class CreateChairsManagers < ActiveRecord::Migration
  def change
    create_table :chairs_managers do |t|
      t.string :url
      t.string :name
      t.boolean :active

      t.timestamps null: false
    end

    add_column :chairs, :chairs_manager_id, :integer
    add_index :chairs, :chairs_manager_id
  end
end
