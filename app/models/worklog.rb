#encoding: utf-8
class Worklog < ActiveRecord::Base
  include Redmine::SafeAttributes
  
  unloadable
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  has_many :worklog_reviews
  
  attr_accessor :plan,:plan_done,:week_feel
  
  TYPEE = {"day" => 0,"week" => 1, "month" => 2, "year" => 3}
  #SCORE = {"1分（最差）" => 1, "2分" => 2, "3分" => 3, "4分" => 4, "5分" => 5, "6分（及格）" => 6, "7分" => 7, "8分" => 8, "9分" => 9, "10分（最好）" => 10}
  SCORE = {"A：超出预期" => 1, "B：完成" => 2, "C：未完成或结果不达标" => 3}

  def plan
   case self.typee
    when 0
      @plan = Worklog.where("user_id = ? and day <> ? and typee = ?", self.user_id,self.day,0).last
    when 1
      @plan = Worklog.where("user_id = ? and week <> ? and typee = ?", self.user_id,self.week,1).last
    when 2
      @plan = Worklog.where("user_id = ? and month <> ? and typee = ?", self.user_id,self.month,2).last
    when 3
      @plan = Worklog.where("user_id = ? and year <> ? and typee = ?", self.user_id,self.year,3).last
    end

  return @plan
  end

  
  def self.typee_collection
      TYPEE.collect { |s| [s[0], s[1]]}
  end
  
  def self.score_collection
      SCORE.collect { |s| [s[0], s[1]]}
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
