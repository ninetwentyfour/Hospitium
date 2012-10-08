task :travis do
  ["rake spec", "rake cucumber"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    system("sudo service memcached restart")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end