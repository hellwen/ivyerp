class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :name, :null => false
      t.string :descript
      t.boolean :active, :default => 1

      t.timestamps
    end

    add_index :jobs, :name, :unique => true
  end
end
