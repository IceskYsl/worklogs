namespace :worklogs do
  
  desc 'Send mail to users to reminder the worklogs.'
  task :day => :environment  do
    day = ENV['day'] || Date.today.to_s
    puts "worklogs:day: day=>#{day}"
    Mailer.with_synched_deliveries do
      WorklogMailer.day_log(day).deliver 
    end
  end
  desc 'week report for worklogs.'
  task :week => :environment  do
    week = ENV['week'] || (Date.today - 1.day).strftime("%W")
    puts "worklogs:week: week=>#{week}"
    Mailer.with_synched_deliveries do
      WorklogMailer.week_report(week).deliver 
    end
  end
  
  
  desc 'fill month and year.'
  task :fill_month => :environment  do
    Worklog.all.each do |w|
      puts "----#{w.id}----"
      w.month = w.created_at.strftime("%m").to_i
      w.year = w.created_at.strftime("%Y").to_i
      w.save()
    end
  end
  
end