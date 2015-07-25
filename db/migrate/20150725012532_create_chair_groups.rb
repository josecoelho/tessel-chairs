class CreateChairGroups < ActiveRecord::Migration
  def change
    create_table :chair_groups do |t|
      t.string :name
      t.timestamps null: false
    end

    add_column :chairs, :chair_group_id, :integer
    add_index :chairs, :chair_group_id
  end
end
