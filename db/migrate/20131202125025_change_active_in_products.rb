class ChangeActiveInProducts < ActiveRecord::Migration
  def up
    change_column :products, :active, :boolean, :default => true
  end

  def down
  end
end
