class AddFeelToWorklogs < ActiveRecord::Migration
  def up
    add_column :worklogs, :feel, :text
  end

  def down
    remove_column :worklogs, :feel
  end
end