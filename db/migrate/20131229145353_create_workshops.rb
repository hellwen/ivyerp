class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :name, :null => false
      t.string :descript

      t.timestamps
    end

    add_index :workshops, :name, :unique => true
  end
end
