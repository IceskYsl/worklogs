# encoding: UTF-8
module WorklogsHelper

  
  def can_edit?(worklog)
    if (worklog.day == Date.today.to_s) && (worklog.user_id == session[:user_id])
      return true
    end
      return false
  end
  
  def worklogs_title(typee=nil)
    if typee == "0"
      return l(:worklogs_title_day)
    elsif typee == "1"
      return l(:worklogs_title_week)
    else
      return l(:worklogs_title_else)
    end
  end

  def score_text(score)
    case score
    when 1
      return "A"
    when 2
      return "B"
    when 3
      return "C"
    else
      return "X"
    end
  end
  
end
