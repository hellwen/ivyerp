class ChangeNameByJobs < ActiveRecord::Migration
  def up
    change_column :jobs, :name, :string, :null => false
  end

  def down
  end
end
