class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :bill_no, :null => false, :unique => true
      t.string :spare_no
      t.date :handle_date, :null => false
      t.integer :type, :null => false
      t.integer :workshop_id
      t.string :handover_person
      t.string :handle_person
      t.integer :status, :null => false
      t.string :remark

      t.timestamps
    end
  end
end
