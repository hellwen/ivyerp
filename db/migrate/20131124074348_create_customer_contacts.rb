class CreateCustomerContacts < ActiveRecord::Migration
  def change
    create_table :customer_contacts do |t|
      t.integer :customer_id
      t.string :title
      t.string :name
      t.string :phone

      t.timestamps
    end
  end
end
