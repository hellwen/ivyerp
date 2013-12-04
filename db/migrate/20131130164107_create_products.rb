class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.integer :customer_id
      t.string :specification
      t.string :remark
      t.integer :active

      t.timestamps
    end

    change_column :products, :name, :string, :null => false 
    change_column :products, :code, :string, :null => false 
    add_index :products, :code, :unique => true
  end
end
