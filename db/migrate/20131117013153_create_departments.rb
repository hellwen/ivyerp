class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name, :null => false
      t.string :descript
      t.boolean :active, :default => 1

      t.timestamps
    end

    add_index :departments, :name, :unique => true
  end
end
