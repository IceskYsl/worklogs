class WorklogMailer < Mailer
  def self.default_url_options
    { :host => Setting.host_name, :protocol => Setting.protocol }
  end
  
  # Builds a Mail::Message object used to email recipients of the added issue.  
  def day_log(day)
    @url = url_for(:controller => 'worklogs', :action => 'index', :day => day)
    @all_users = User.status("1").where("id > 1") #.all - User.find(1)
    recipients = @all_users.collect(&:mail)
    @day = day || Date.today.to_s
    @worklogs = Worklog.where("status = 0").where(:day => @day)
    
    @sended_user_ids = @worklogs.collect(&:user_id).uniq
    # @no_need_users_ids = [1,61,55,46]
    @no_need_users_ids = Worklog.no_need_users_ids
    @need_user_ids = @all_users.collect(&:id) - @no_need_users_ids
    @unsended_users = User.find(@need_user_ids - @sended_user_ids)
    
    #recipients
    mail :to =>  recipients ,
         :cc => "pml@eoemobile.com",
         :subject => l(:mail_subject_worklog_day, day)
  end
  
end