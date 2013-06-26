module WorklogsHelper
  
  def can_edit?(worklog)
    if (worklog.day == Date.today.to_s) && (worklog.user_id == session[:user_id])
      return true
    end
      return false
  end
end
