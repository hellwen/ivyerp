class RenameStateToStatusInStocks < ActiveRecord::Migration
  def up
    rename_column :stocks, :state, :status
    rename_column :stocks, :type, :opt_type
  end

  def down
  end
end
