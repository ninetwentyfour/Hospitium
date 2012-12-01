task :travis do
  # ["rake spec", "rake cucumber"].each do |cmd|
  #   puts "Starting to run #{cmd}..."
  #   system("export DISPLAY=:99.0 && bundle exec #{cmd}")
  #   raise "#{cmd} failed!" unless $?.exitstatus == 0
  # end
  ["rake spec", "bundle exec cucumber"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
  # ["rake spec"].each do |cmd|
  #   puts "Starting to run #{cmd}..."
  #   system("export DISPLAY=:99.0 && bundle exec #{cmd}")
  #   raise "#{cmd} failed!" unless $?.exitstatus == 0
  # end
end