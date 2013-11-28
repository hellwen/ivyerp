class CreateCustomerShippings < ActiveRecord::Migration
  def change
    create_table :customer_shippings do |t|
      t.integer :customer_id
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
