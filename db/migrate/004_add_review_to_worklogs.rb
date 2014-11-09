#encoding: utf-8
class AddReviewToWorklogs < ActiveRecord::Migration
  def up
    create_table :worklog_reviews, :force => true do |t|
      t.column :worklog_id, :integer, :default => 0, :null => false
      t.column :user_id, :integer, :default => 0, :null => false
      t.column :score, :integer, :default => 0, :null => false #-1;0;1
      t.column :review, :text
      t.timestamp :created_at
    end
    add_index :worklog_reviews,:worklog_id


  end

  def down
  	remove_table :worklog_reviews
  end
end