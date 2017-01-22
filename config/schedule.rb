set :output, "log/cron.log"
set :environment, :development
env :PATH, ENV['PATH']

every 1.minute do
  runner "Tasks::CheckDeadline.execute"
end
