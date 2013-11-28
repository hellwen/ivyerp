class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :code, :null => false
      t.string :name, :null => false
      t.string :remark
      t.boolean :active, :default => true

      t.timestamps
    end

    add_index :customers, :code, :unique => true
  end
end
