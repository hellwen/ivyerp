class CreateItems < ActiveRecord::Migration
  def change
    create_table :items, :id => false do |t|
      t.string  :type
      t.integer :item_id
      t.integer :order
      t.string  :name
      t.boolean :active

      t.timestamps
    end

    add_index :items, [:type, :item_id], :unique => true
    add_index :items, [:type, :name], :unique => true
  end
end
