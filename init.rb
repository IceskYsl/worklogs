Redmine::Plugin.register :worklogs do
  name 'Worklogs plugin'
  author 'Iceskysl'
  description 'This is a worklogs plugin for Redmine'
  version '0.0.1'
  url 'http://my.eoemobile.com/worklogs'
  author_url 'http://my.eoe.cn/iceskysl'
  
  menu :top_menu, :worklogs, { :controller => 'worklogs', :action => 'index' }, :caption => :label_worklog

  menu :application_menu, :index_worklogs, { :controller => 'worklogs', :action => 'index' }, :caption => :label_worklog
  menu :application_menu, :new_worklogs, { :controller => 'worklogs', :action => 'new' }, :caption => :label_worklog_new, :last => true
end
