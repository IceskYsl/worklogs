Redmine::Plugin.register :worklogs do
  name 'Worklogs plugin'
  author 'Iceskysl'
  description 'This is a worklogs plugin for Redmine'
  version '0.1.0'
  url 'https://github.com/IceskYsl/worklogs'
  author_url 'http://my.eoe.cn/iceskysl'
  
  menu :top_menu, :worklogs, { :controller => 'worklogs', :action => 'index' }, :caption => :label_worklog

  menu :application_menu, :worklogs, { :controller => 'worklogs', :action => 'index' }, :caption => :label_worklog
  menu :application_menu, :worklogs_my, { :controller => 'worklogs', :action => 'my'}, :caption => :label_worklog_my
  menu :application_menu, :worklogs_new, { :controller => 'worklogs', :action => 'new' }, :caption => :label_worklog_new, :last => true
end
