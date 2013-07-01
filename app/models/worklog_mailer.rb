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
    @sended_users = @worklogs.collect(&:user_id).uniq
    @unsended_users = User.find(@all_users.collect(&:id) - @sended_users )
    
    #recipients
    mail :to => recipients ,
         :cc => "pml@eoemobile.com",
         :subject => l(:mail_subject_worklog_day, day)
  end
  
end