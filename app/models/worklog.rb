class Worklog < ActiveRecord::Base
  include Redmine::SafeAttributes
  
  unloadable
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  
  
  TYPEE = {"day" => 0,"week" => 1, "month" => 2}
  
  def self.typee_collection
      TYPEE.collect { |s| [s[0], s[1]]}
  end
  
  def self.no_need_users_ids
    #format: 1,2
    no_need_users_ids = []
    unless Setting.plugin_worklogs['WORKLOGS_UN_IDS'].blank?
      Setting.plugin_worklogs['WORKLOGS_UN_IDS'].split(",").each do |i|
        no_need_users_ids << i.to_i
      end      
    end
    #no_need_users_ids:["1", "61", "55", "46"]
    logger.info("no_need_users_ids:#{no_need_users_ids}")
    no_need_users_ids
  end
  
  def self.no_need_users
    no_need_users_ids = Worklog.no_need_users_ids
    User.find(no_need_users_ids)
  end
  
  #use to migration week data
  def self.mig_week
    Worklog.all.each do |w|
      week = Date.parse(w.day).strftime("%W")
      w.week = week
      w.save
    end
    
  end
end
