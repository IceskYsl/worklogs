#encoding: utf-8
class WorklogReview < ActiveRecord::Base
  include Redmine::SafeAttributes
  
  unloadable
  belongs_to :user
  belongs_to :worklog

  after_create :delive_review

  SCORES = {"A（超出预期）" => 1,"B（完成）" => 2,"C（未完成或者结果不达标）" => 3}

  #邮件通知
  def delive_review
    logger.info("=========delive_review ...")
    Mailer.with_synched_deliveries do
      WorklogMailer.review(self).deliver 
    end 
  end  

  def self.scores_collection
  	SCORES.collect { |s| [s[0], s[1]]}
  end

  def like_text
  	case score
  	when 1
  		return "A（超出预期）"
  	when 2
  		return "B（完成）"
  	when 3
  		return "C（未完成或者结果不达标）"
  	end
  end


end