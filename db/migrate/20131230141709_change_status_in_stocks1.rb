class ChangeStatusInStocks1 < ActiveRecord::Migration
  def up
    change_column :stocks, :status, :string, :limit => 20, :null => false
  end

  def down
  end
end
