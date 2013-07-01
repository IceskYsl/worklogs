namespace :worklogs do
  
  desc 'Send mail to users to reminder the worklogs.'
  task :day => :environment  do
    day = ENV['day'] || Date.today.to_s
    puts "worklogs:day: day=>#{day}"
    Mailer.with_synched_deliveries do
      WorklogMailer.day_log(day).deliver 
    end
  end
  
end