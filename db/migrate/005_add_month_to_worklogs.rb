#encoding: utf-8
class AddMonthToWorklogs < ActiveRecord::Migration
  def up
    add_column :worklogs, :month, :integer
    add_column :worklogs, :year, :integer
  end

  def down
    remove_column :worklogs, :month
    remove_column :worklogs, :year
  end
end