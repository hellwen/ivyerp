class AddPositionToCustomerContacts < ActiveRecord::Migration
  def change
    add_column :customer_contacts, :position, :integer
  end
end
