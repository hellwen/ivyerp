class ChangeStatusInStocks < ActiveRecord::Migration
  def up
    rename_column :stocks, :status, :state
    change_column :stocks, :state, :string, :limit => 1, :null => false
  end

  def down
  end
end
