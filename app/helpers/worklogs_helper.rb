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
      return "日报日志"
    elsif typee == "1"
      return "周报日志"
    else
      return "工作日志"
    end
  end
  
end
