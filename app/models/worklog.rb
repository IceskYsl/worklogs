class Worklog < ActiveRecord::Base
  include Redmine::SafeAttributes
  
  unloadable
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  
  
  TYPEE = {"day" => 0,"week" => 1, "month" => 2}
  
  def self.typee_collection
      TYPEE.collect { |s| [s[0], s[1]]}
  end
  
  def self.no_need_users_ids
    #1,2
    Setting.plugin_worklogs['WORKLOGS_UN_IDS'].split(",")
  end
  
  def self.no_need_users
    User.find(Worklog.no_need_users_ids)
  end
end
