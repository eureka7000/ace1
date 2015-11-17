before_fork do |server, worker|
  old_pid = RAILS_ROOT + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

$ kill -s USR2 12113

$ pgrep -lf unicorn_rails
12113 unicorn_rails master (old) -c config/unicorn.rb -D
12118 unicorn_rails worker[0] -c config/unicorn.rb -D
12136 unicorn_rails worker[1] -c config/unicorn.rb -D
12137 unicorn_rails worker[2] -c config/unicorn.rb -D
12239 /usr/bin/ruby1.8 /usr/bin/unicorn_rails -c config/unicorn-dev.rb -D

$ pgrep -lf unicorn_rails
12239 unicorn_rails master -c config/unicorn-dev.rb -D
12245 unicorn_rails worker[0] -c config/unicorn-dev.rb -D
12246 unicorn_rails worker[1] -c config/unicorn-dev.rb -D