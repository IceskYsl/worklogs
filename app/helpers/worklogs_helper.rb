# encoding: UTF-8
module WorklogsHelper

  
  def can_edit?(worklog)
    if ((worklog.day == Date.today.to_s) || (worklog.week == Date.today.strftime("%W").to_i)) && (worklog.user_id == session[:user_id])
      return true
    end
      return false
  end
  
  def worklogs_title(typee=nil)
    if typee == "0"
      return l(:worklogs_title_day)
    elsif typee == "1"
      return l(:worklogs_title_week)
    elsif typee == "2"
      return l(:worklogs_title_month)
    elsif typee == "3"
      return l(:worklogs_title_year)
    else
      return l(:worklogs_title_else)
    end
  end

  def worklogs_index_title(typee=nil)
    #puts "#{typee}----"
    if typee == 0
      return l(:index_type_day)
    elsif typee == 1
      return l(:index_type_week)
    elsif typee == 2
      return l(:index_type_month)
    elsif typee == 3
      return l(:index_type_year)
    else
      return l(:index_type_else)
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
