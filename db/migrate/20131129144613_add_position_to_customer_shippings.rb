class AddPositionToCustomerShippings < ActiveRecord::Migration
  def change
    add_column :customer_shippings, :position, :integer
  end
end
