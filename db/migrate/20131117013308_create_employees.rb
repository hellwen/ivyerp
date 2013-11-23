class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string  :code, :null => false, :limit => 20
      t.string  :name, :null => false

      # public info
      t.string  :email
      t.string  :phone
      t.string  :mobile
      t.string  :office_location
      t.integer :department_id
      t.integer :job_id

      # personal info
      t.integer :sex
      t.string  :id_card
      t.string  :home_addr
      t.date    :date_of_birth

      # other info
      t.string  :remark
      t.date    :date_of_leaved
      t.boolean :active

      t.timestamps
    end

    add_index :employees, :code, :unique => true
  end
end
