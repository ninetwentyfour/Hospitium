task :travis do
  # ["rake spec", "rake cucumber"].each do |cmd|
  #   puts "Starting to run #{cmd}..."
  #   system("export DISPLAY=:99.0 && bundle exec #{cmd}")
  #   raise "#{cmd} failed!" unless $?.exitstatus == 0
  # end
  # ["rake spec", "rake db:test:prepare", "cucumber"].each do |cmd|
  #   puts "Starting to run #{cmd}..."
  #   system("export DISPLAY=:99.0 && bundle exec #{cmd}")
  #   raise "#{cmd} failed!" unless $?.exitstatus == 0
  # end
  ['rake test_with_coveralls'].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $CHILD_STATUS.exitstatus == 0
  end
end
